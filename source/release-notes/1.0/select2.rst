Select2
=======

.. danger:: This is a major breakdown.

We dropped the dependency ``ivaynberg/wicket-select2`` and now use
``select2-parent`` from ``wicektstuff`` to get the lastest v4 of ``Select2``.

* Remove deprecated ``org.iglooproject.wicket.more.markup.html.select2.AbstractSelect2MultipleChoice``
* Remove deprecated ``org.iglooproject.wicket.more.markup.html.select2.Select2CollectionMultipleChoice``
* Remove deprecated ``org.iglooproject.wicket.more.markup.html.select2.Select2ListMultipleChoice``
* Remove deprecated ``org.iglooproject.wicket.more.markup.html.select2.Select2SortedSetMultipleChoice``
|
* Remove ``org.iglooproject.wicket.more.markup.html.select2.AjaxSearchResourceReference``. Not the same API anymore, rebuild it from scratch if necessary.
* Remove ``org.iglooproject.wicket.more.markup.html.select2.AbstractGenericEntitySelect2AjaxResourceReference``. Not the same API anymore, rebuild it from scratch if necessary.
|
* Remove ``select2.less``
|
* Remove ``Select2Utils.CSS_DROP_MINI``;
* Remove ``Select2Utils.String CSS_DROP_SMALL``;
* Remove ``Select2Utils.String CSS_DROP_MEDIUM``;
* Remove ``Select2Utils.CSS_DROP_LARGE``;
* Remove ``Select2Utils.CSS_DROP_XLARGE``;
* Remove ``Select2Utils.CSS_DROP_XXLARGE``;
* Remove ``Select2Utils.CSS_DROP_XXXLARGE``
