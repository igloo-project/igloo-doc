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