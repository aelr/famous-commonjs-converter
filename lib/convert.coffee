path = require 'path'
fs = require 'fs-extra'
wrench = require 'wrench'
_ = require 'lodash'
helpers = require './helpers'

original = "../famous"
converted = "../famous-commonjs"
blacklist = [".git"]

# Remove old conversion
try
  wrench.rmdirSyncRecursive(converted)
catch e
  throw e if e.message.indexOf("ENOENT") isnt 0

# Create output folder
fs.mkdir converted

# Copy correct files to conversion folder
files = fs.readdirSync(original)
_.each files, (file) ->
  return if _.contains(blacklist, file)
  inPath = path.join(original, file)
  outPath = path.join(converted, file)
  console.log "Copying #{inPath} to #{outPath}"
  fs.copySync inPath, outPath

debugger
why = 7