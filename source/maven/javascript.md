# Javascript

## Purpose

We need to use npm build process for some client-side javascript components. This is
needed to customize third-party libraries (bootstrap, ...), as it is needed to work
on source javascript file, and not with generated/transpiled resources.

This use-case may be addressed with:

* third-party pure-javascript/npm repositories that provides npm packages we can embed
  in java application with webjars. This solution implies to create new repositories,
  manage their build/publish processes, and add steps for development environment setup;
* adapt mvn build to include npm building phases. It allows to keep an unified
  development/build/publish process.

For the time being we use the second solution. First solution may be used for bigger
javascript development, to ease third-party contribution or to share individual javascript
components.

## Architecture

This description use `bootstrap5-override` as an example.

The purpose of `bootstrap5-override` is to package *bootstrap* resources into a webjar
and to customize some resources.

Migrating from *bootstrap 4* to *bootstrap 5*, it is prefered to switch from a process where
we can override published resources to a model where we have to override bootstrap sources.

It allows us to prepare our customization base on es2015+ sources, so we can write simpler
source code (module import, native class inheritance instead of prototype customization, ...)

## Build process

## How to update Javascript resources in development environment

### Project structure

Writing JS that is not necessarily usable with the browser. So we use `npm` to avoid this problem.
We will have a concrete example to test and we will be able to do unit tests.

- `src/main/js/*.js` : development files
- `src/main/generated-js/js` : files generated from the development files

#### rollup.config :
 - **input** : input development file
 - **output** :
   - file: processed output file
   - format :
     - `UMD` (Universal Module Definition) : format managed on the browser side
     - `ESM` (ES Modules) : managed in node
   - generatedCode : standard to use -> how I should transform the JS
   - globals : specification of import aliases
 - **external** : external library available, avoid importing everything
 - **plugins** : the plugins to use
   - `babel` : allows to transpile code
      -> transform code from one language to another, in our case, only JS but in different versions
   - `resolve` : allows to find missing dependencies


#### package.json :
 - **scripts** : alias allowing to execute several commands or other aliases at once

### Usage

Example of use in igloo with `bootstrap5-override`.
To use the commands, go to `igloo-parent/igloo/igloo-webjars/bootstrap5-override/`.
It becomes possible to use the commands seen in the `package.json` file.  
To see the list of available commands, just run: `npm run-script`.
We note that these are aliases that allow to call several commands or other aliases. The most commonly used are :
- `npm run-script js` : generates files from development files -> transpiling, management of missing modules and code restructuring
- `npm run-script start` : starts the hugo server

TODO : talk about the maven package that processes files during the clean project