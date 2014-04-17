# Famo.us CommonJS Converter

This tool converts the Famo.us framework from AMD to CommonJS.
It also includes an example using this version with browserify in the `example` directory.  It was generated via:

1. `npm install -g browserify` (if not already installed)
2. `browserify example/browserify-app.js > example/browserify-built.js`
3. Open `example/browserify.html` in a browser.  The example used is from the
[Famo.us examples](https://github.com/Famous/examples) repo.

It brings in all used modules into a file, ready for minimization.
See browserify for information on source map support if desired.
