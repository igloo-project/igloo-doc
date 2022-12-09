(jimportdiff)=

# jimportdiff

Long-term Igloo maintenance implies to split some code by modules, to ease
testing, code and repository management. It implies to rename some java packages,
so that some Igloo release are not backward compatible.

To ease Igloo project code rewriting on migration, `jimportdiff` is written to
generate Igloo release report (what class/package/module is created in a new release).

It works by comparing two Igloo source tree to track deletion and code moves.

Tool is located here: https://github.com/igloo-project/jimportdiff.

Release notes provide further information when `jimportdiff` is appropriate.


## Generate a release report

```
pipenv run ./jimportdiff rewrite --migration igloo5 igloo-4.4.1-5.0.0.json ../target-project
```
