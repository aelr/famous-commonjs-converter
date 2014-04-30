path = require 'path'
fs = require 'fs-extra'
os = require 'os'
S = require 'string'
_ = require 'lodash'

defineStart = "define(function(require, exports, module) {"
defineEnd = "});"

requireMatch = /require\(["|'](.+?)["|']\)/i

module.exports = helpers =
  original: "famous"
  converted: "famous-commonjs"
  processFile: (file) ->
    path
    console.log "Converting to CommonJS: #{file}"
    contents = fs.readFileSync file
    relativePath = path.relative("#{process.cwd()}/#{helpers.converted}", file)
    currentFileDepth = relativePath.split(path.sep).length - 1
    debugger if file.indexOf "Engine" isnt -1
    updated = helpers.removeAMDBlock contents.toString(), currentFileDepth
    fs.writeFileSync file, updated
    return

  removeAMDBlock: (contents, currentDepth) ->
    lines = contents.split os.EOL
    eol = os.EOL
    if lines.length is 1
      lines = contents.split "\n"
      eol = "\n"

    inAMDBlock = false
    for line,i in lines by 1
      if line is defineStart
        lines[i] = ""
        inAMDBlock = true
      else if lines[i] is defineEnd
        lines[i] = ""
        inAMDBlock = false
      else if inAMDBlock
        temp = S(line).chompLeft("    ")
        if requireMatch.test(temp)
          requirePath = helpers.pullRequirePath temp
          fixedRequirePath = helpers.fixRequirePath(requirePath, currentDepth)
          temp = temp.replace requirePath, fixedRequirePath
        lines[i] = temp

    lines.join(eol)

  fixRequirePath: (requirePath, depthOfCall) ->
    if depthOfCall > 1
      debugger
    if requirePath.indexOf('famous/') is 0
      levels = _.map _.range(depthOfCall), (level) -> ".."
      relativePath = levels.join '/'
      requirePath.replace 'famous', relativePath
    else # Assume relative requirePath already used
      requirePath

  pullRequirePath: (line) ->
    line.match(requireMatch)[1]