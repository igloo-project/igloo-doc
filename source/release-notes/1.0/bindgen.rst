Bindgen
-------

Bindgen is updated to 4.0.0. This new version uses lambda for binding
generation.

You need to handle the following issues:

* AbstractBinding must not be used; please use BindingRoot.
* AbstractCoreBinding must not be used; please use ICoreBinding.
* If you use a custom parent binding class in your project, you need to adapt
  it to work with the new version. Check AbstractCoreBinding.java history
  in https://github.com/igloo-project/bindgen-java project to help you.

This script should handle these updates:

.. literalinclude:: bindgen-replace.sh
  :language: bash
