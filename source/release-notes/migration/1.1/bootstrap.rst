Bootstrap
=========

Bootstrap 3
-----------

Bootstrap 3 is now deprecated. If you use it, you need to add
igloo-component-wicket-bootstrap3 as a dependency, and to run the following
script:

.. literalinclude:: scripts/bootstrap3-replace.sh
   :language: bash

Bootstrap Modal
---------------

* Remove `Bootstrap Modal override plugin <https://github.com/jschr/bootstrap-modal>`_
  in BS4 module. Use default Bootstrap modal js file and css style.
  At this time, modal markup is in the html flow (according to Wicket
  components hierarchy), where the component is added - this may cause some
  display / style issues.
* In both BS3 and BS4 cases, remove ``loading`` and ``removeLoading`` statements.
  Use ``BootstrapModalStatement`` instead of ``BootstrapModalManagerStatement``.
* Sizing: in BS4, use ``AbstractModalPopupPanel#dialogCssClass(IModel<String> dialogCssClassModel)``
  instead of ``AbstractModalPopupPanel#getCssClassNamesModel()`` to add sizing
  css classes.
