Wicket & UI
===========

.. note:: Updated to Wicket 8. Read the `Wicket 8 migration guide <https://cwiki.apache.org/confluence/display/WICKET/Migration+to+Wicket+8.0>`_.

Model
-----

* Remove ``org.iglooproject.wicket.more.model.ClassModel.java``.
  This model was useless and potentially harmful in a multithreaded context.
  Use ``Model.of()`` instead.
* Remove ``org.iglooproject.wicket.more.model.GenericEntityArrayListModel.java``.
  Use ``CollectionCopyModel`` with ``Suppliers2`` and ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.model.GenericEntityHashSetModel.java``.
  Use ``CollectionCopyModel`` with ``Suppliers2`` and ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.model.GenericEntityLinkedHashSetModel``.java.
  Use ``CollectionCopyModel`` with ``Suppliers2`` and ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.model.GenericEntityTreeSetModel.java``.
  Use ``CollectionCopyModel`` with ``Suppliers2`` and ``GenericEntityModel`` instead.
* Remove ``CompositeSortModel#getOrder()``.
  Use ``CompositeSortModel#getActiveOrder(ISort)``
  or ``CompositeSortModel#getSelectedOrder(ISort)`` instead.

Component
---------

* Remove ``org.iglooproject.wicket.markup.html.basic.HideableLabel.java``.
  Use ``CoreLabel`` with ``hideIfEmpty()`` instead.
* Remove ``org.iglooproject.wicket.markup.html.basic.HideableMultiLineLabel.java``.
  Use ``CoreLabel`` with ``multiline()`` and ``hideIfEmpty()`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.basic.BigDecimalToIntegerLabel.java``.
  Use ``Renderer.fromStringFormat("%1$.0f").asLabel(id, model))``
  to get the exact same result.
* Remove ``org.iglooproject.wicket.more.markup.html.basic.LocaleLabel.java``.
  Use ``CoreLabel`` with ``Renderer`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.basic.PercentageValueLabel.java``.
  Use new ``CoreLabel(id, CoreRenderers.percent().asModel(model))``
  in most case ('#0.00 %' with a ratio value (from 0 to 1)) instead.
  To display a non-ratio value (from 0 to 100 for instance), use your own
  ``DecimalFormat`` with ``df.setMultiplier(1)``,
  see ``CoreRenderers#percentDecimalFormatFunction(String, RoundingMode)``.
* Remove ``org.iglooproject.wicket.more.markup.html.image.BooleanGlyphicon.java``. Use ``BooleanIcon`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.image.BooleanImage.java``. Use ``BooleanIcon`` instead.
* Remove some public constructors from ``AjaxConfirmButton``.
* Remove ``org.iglooproject.wicket.more.markup.html.form.AbstractQuickSearchComponent.java``.
  Use Ajax Select2 with ``UpdateOnChangeAjaxEventBehavior`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.form.AutocompleteAjaxComponent.java``.
  Use Ajax Select2 instead.

RepeatingView
-------------

* Remove ``org.iglooproject.wicket.more.markup.html.collection.AbstractGenericCollectionView.java``.
  Use ``CollectionView`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.AbstractGenericEntityCollectionView.java``.
  Use ``CollectionView`` with ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.GenericEntityCollectionView.java``.
  Use ``CollectionView`` with ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.GenericEntityListView.java``.
  Use ``CollectionView`` with ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.GenericEntitySetView.java``.
  Use ``CollectionView`` with ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.GenericEntitySortedSetView.java``.
  Use ``CollectionView`` with ``GenericEntityModel`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.AbstractSerializedItemCollectionView.java``.
  Use ``CollectionView`` with ``Models`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.SerializedItemCollectionView.java``.
  Use ``CollectionView`` with ``Models`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.SerializedItemListView.java``.
  Use ``CollectionView`` with ``Models`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.SerializedItemSetView.java``.
  Use ``CollectionView`` with ``Models`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.collection.SerializedItemSortedSetView.java``.
  Use ``CollectionView`` with ``Models`` instead.
* Remove ``org.iglooproject.wicket.more.markup.repeater.data.GenericEntityListModelDataProvider.java``.
  Use ``ISequenceProvider`` instead.
* Remove ``org.iglooproject.wicket.more.markup.repeater.data.OddEvenDataView.java``.
  Use Bootstrap css classes instead.

Visibility
----------

* Remove ``org.iglooproject.wicket.more.markup.html.basic.EnclosureBehavior.java``.
  Use ``Condition`` or implement your own ``AbstractConfigurableComponentBooleanPropertyBehavior`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.basic.PlaceholderBehavior.java``.
  Use ``Condition`` or implement your own ``AbstractConfigurableComponentBooleanPropertyBehavior`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.basic.AbstractHidingBehavior.java``.
  Use ``AbstractComponentBooleanPropertyBehavior`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#collectionModel(IModel)``.
  Use ``Condition#collectionModelNotEmpty(IModel)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#model(IModel)``.
  Use ``Condition#modelNotNull(IModel)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#model(Predicate, IModel)``.
  Use ``Condition#predicate(IModel, Predicate)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#models(IModel, IModel...)``.
  Use ``Condition#modelsAnyNotNull(IModel, IModel...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#models(Predicate, IModel, IModel...)``.
  Use ``Condition#predicateAnyTrue(Predicate, IModel, IModel...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#component(Component)``.
  Use ``Condition#componentVisible(Component)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#components(Component, Component...)``.
  Use ``Condition#componentsAnyVisible(Component, Component...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyContainer#components(Collection)``.
  Use ``Condition#componentsAnyVisible(Collection)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#collectionModel(IModel)``.
  Use ``Condition#collectionModelNotEmpty(IModel)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#model(IModel)``.
  Use ``Condition#modelNotNull(IModel)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#model(Predicate, IModel)``.
  Use ``Condition#predicate(IModel, Predicate)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#models(IModel, IModel...)``.
  Use ``Condition#modelsAnyNotNull(IModel, IModel...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#models(Predicate, IModel, IModel...)``.
  Use ``Condition#predicateAnyTrue(Predicate, IModel, IModel...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#component(Component)``.
  Use ``Condition#componentVisible(Component)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#components(Component, Component...)``.
  Use ``Condition#componentsAnyVisible(Component, Component...)`` instead.
* Remove ``AbstractConfigurableComponentBooleanPropertyBehavior#components(Collection)``.
  Use ``Condition#componentsAnyVisible(Collection)`` instead.

Factory
-------

* Remove ``org.iglooproject.wicket.more.markup.html.factory.AbstractDetachableFactory``.
  Use ``IDetachableFactory`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.factory.IOneParameterConditionFactory.java``.
  Use ``IDetachableFactory`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.factory.AbstractOneParameterConditionFactory.java``.
  Use ``IDetachableFactory`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.factory.IOneParameterModelFactory.java``.
  Use ``IDetachableFactory`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.factory.AbstractOneParameterModelFactory.java``.
  Use ``IDetachableFactory`` instead.
* Remove ``ComponentFactories#addAll(RepeatingView, Iterable)``.
  Use ``FactoryRepeatingView`` instead.
* Remove ``ComponentFactories#addAll(RepeatingView, Iterable, P)``.
  Use ``FactoryRepeatingView`` instead.

Action
------

* Remove ``org.iglooproject.wicket.more.markup.html.action.AbstractAction``.
  Use ``IAction`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.action.AbstractAjaxAction``.
  Use ``IAjaxAction`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.action.AbstractOneParameterAction``.
  Use ``IOneParameterAction`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.action.AbstractOneParameterAjaxAction``.
  Use ``IOneParameterAjaxAction`` instead.
* Remove ``org.iglooproject.wicket.more.markup.html.template.js.jquery.plugins.bootstrap.confirm.util.AjaxResponseAction``.
  Use ``IOneParameterAjaxAction`` instead.

Condition
---------

* Remove ``Condition#asValue(IModel<? extends T>, IModel<? extends T>)``.
  Use ``.then(...).otherwise(...)`` instead.
* Remove ``Condition#asValue(T, T)``.
  Use ``.then(...).otherwise(...)`` instead.

DataTableBuilder
----------------

* Remove ``IAddedLabelColumnState#withLink(LinkGeneratorFactory<T>)``.
  Use ``IAddedLabelColumnState#withLink(ILinkDescriptorMapper)`` instead.
* Remove ``IAddedLabelColumnState#withLink(AbstractCoreBinding<? super T, C>, LinkGeneratorFactory<C>)``.
  Use ``IAddedLabelColumnState#withLink(AbstractCoreBinding, ILinkDescriptorMapper)`` instead.
* Remove ``IAddedLabelColumnState#withSideLink(LinkGeneratorFactory<T>``.
  Use ``IAddedLabelColumnState#withSideLink(ILinkDescriptorMapper)`` instead.
* Remove ``IAddedLabelColumnState#withSideLink(AbstractCoreBinding<? super T, C>, LinkGeneratorFactory<C>)``.
  Use ``IAddedLabelColumnState#withSideLink(AbstractCoreBinding, ILinkDescriptorMapper)`` instead.
* Remove ``IBuildState#hideTopToolbar()``.
  Use ``IBuildState#hideHeadersToolbar()`` instead.
* Remove ``IBuildState#hideBottomToolbar()``.
  Use ``IBuildState#hideNoRecordsToolbar()`` instead.

Renderer and Converter
----------------------

* Remove ``org.iglooproject.wicket.more.util.convert.converters.HumanReadableEnumConverter.java``
* Remove ``org.iglooproject.wicket.more.util.convert.converters.HumanReadableLocaleConverter.java``
* Remove ``org.iglooproject.wicket.markup.html.model.EnumLabelModel.java``. Use ``EnumRenderer`` instead:
	- ``new EnumLabelModel(enumValueModel)`` should become ``EnumRenderer.get().asModel(enumValueModel)``
	- ``new EnumLabelModel(enumValueModel, nullKeyValue)`` should become ``EnumRenderer.get().nullsAsResourceKey(nullKeyValue).asModel(enumValueModel)``
	- ``new EnumLabelModel(enumValue)`` should become ``EnumRenderer.get().asModel(new Model<>(enumValue))``
	- ``new EnumLabelModel(enumValue, nullKeyValue)`` should become ``EnumRenderer.get().nullsAsResourceKey(nullKeyValue).asModel(new Model<>(enumValue))``
* Remove ``org.iglooproject.wicket.more.markup.html.bootstrap.label.renderer.BootstrapLabelRenderer.java``.
  Use ``BootstrapRenderer`` instead.
* Remove ``BooleanRenderer#BooleanRenderer()`` and ``BooleanRenderer#BooleanRenderer(String, String)``.
  Use static factory methods instead.
* Remove ``EnumRenderer#EnumRenderer()`` and ``EnumRenderer#EnumRenderer(String, String)``.
  Use static factory methods instead.
* Remove ``LocaleRenderer#LocaleRenderer()``.
  Use ``LocaleRenderer#get()`` instead.
* Remove ``Renderer#from(Renderer<? super T>)``.
  Use the parameter ``Renderer`` as-is.

Breadcrumb
----------

``BreadCrumbElement``: remove deprecated support for page class + parameters.
Use a ``LinkDescriptor`` instead. Remove ``LinkBreadCrumbElementPanel`` as well.

DatePickerSync
--------------

DatePickerSync exclusively use ``precedents`` (previous) and ``suivants`` (next)
attributes. There is no longer ``courant`` (current) field.

FileUploadMediaTypeValidator
----------------------------

``FileUploadMediaTypeValidator#errorResourceKey`` and ``FileUploadMediaTypeValidator.setErrorResourceKey(String)``
and related constructor are removed. If you use this property, you now need to
use component-based resource naming (so ``FileUploadMediaTypeValidator``, or
``<fieldName>.FileUploadMediaTypeValidator`` or ``<form>.<fieldName>.FileUploadMediaTypeValidator``).

Bootstrap
---------

* Move ``BootstrapColor``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.model``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.model``.
* Move ``IBootstrapColor``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.model``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.model``.
* Move ``BootstrapRenderer``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.renderer``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.renderer``.
* Move ``BootstrapRendererInformation``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.renderer``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.renderer``.
* Move ``IBootstrapRendererModel``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.renderer``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.renderer``.
* Move ``BootstrapColorBehavior``
  from ``org.iglooproject.wicket.more.markup.html.bootstrap.label.behavior``
  to ``org.iglooproject.wicket.more.markup.html.bootstrap.common.behavior``.

Misc
....

* Remove ``AjaxListeners#refresh(MarkupContainer, Class<? extends Component>, Class<? extends Component>...)``.
  Use ``AjaxListeners#refreshChildren(MarkupContainer, Class, Class...)`` instead.
* Remove redirect methods from ``CoreWebPage``. Theses methods hide
  the exception throwing, which makes dead code harder to spot. Just throw
  a ``RestartResponseException`` or a ``RedirectToUrlException`` yourself.
  Note that if you're using a ``IPageLinkGenerator``, it can instantiate
  the exception for you.
* Remove ``CoreWebPage#visible(Component, boolean)``.
  Just use ``Component#setVisible(boolean)``
  or ``Component#setVisibilityAllowed(boolean)``,
  or (better) add an ``EnclosureBehavior`` to manage the
  component's visibility declaratively.
* Remove ``NavigationMenuItem#isAccessible()``.
  Use the ``NavigationMenuItem#linkHidingIfInvalid(String)`` to create a link
  that will be hidden when it is invalid, or a ``BlankLink`` when the
  ``NavigationMenuItem`` does not have any ``LinkGenerator``.
* Remove ``PredicateValidator#PredicateValidator(Predicate, String)``.
  Use ``PredicateValidator#of(Predicate)`` and then ``PredicateValidator#errorKey(String)``.
* Remove ``org.iglooproject.wicket.more.security.authorization.AuthorizeRenderIfPermissionOnModelObject.java``.
  Use validation features in ``LinkDescriptors`` instead.
  See ``IValidatorState#permission(IModel, String, String...)``.
