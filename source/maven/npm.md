(maven-npm)=

# NPM & Maven

`igloojs` and `bootstrap5-override` uses npm packaging to process source to
distribution-ready browser-side javascripts.

Both integrates with maven by using `frontend-maven-plugin`. Configuration is
splitted between node/npm/rollup configuration (transform resources from
`src/main/js` to `src/main/generated-js`) and maven configuration
(trigger build and package `src/main/generated-js` as a webjar).

If you need to use the same mechanism for another module, see
{igloo-maven}`plugins-npm/README.md`.