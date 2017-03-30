# UI Displaying Collections

This page explains how to display collections using OWSI-Core. Several methods are provided, ordered from easiest to the hardest: use the first that fits, so as to avoid unnecessary complexity.

## Data sources

### Choosing your implementation

There are several types of objects you may use to build an object that will make up the interface between your service/data layers and your view.

#### When getting data from an entity

If you want to retrieve the data directly from an entity attribute (`myEntity.getMyCollection()`) you may use a `BindingModel`. See [UI-Models](UI-Models.html) for more information.

#### When getting data from a service or `IQuery`

If you're not familiar with data querying in OWSI-Core, you probably should read [Querying](Querying.html) before going on.

##### Special case: `ISearchQuery`

If your query is an `ISearchQuery` (`AbstractHibernateSearchSearchQuery` or `AbstractJpaSearchQuery`), you may simply extend `AbstractSearchQueryDataProvider`. The typical implementation will:

 * define some `IModel` attributes and getters, for the search parameters. These models will be used in a form, so that the user may alter them.
 * implement `getSearchQuery` by:
   * calling `createSearchQuery()` with the query interface type (`IMyQuery.class`) as a parameter ;
   * and then calling methods on the resulting query in order to set the search parameters.

##### Other cases (service method call or non-search `IQuery`)

 * If your query uses paging (with an offset and a limit), you'd better define a `IDataProvider`. A good place to start is `LoadableDetachableDataProvider`, which you should try extending. Also, see [UI-Models](UI-Models.html) for more information on `LoadableDetachableDataProvider` and its caveats.
 * If your query has no paging feature, you may simply define your own `IModel<WhateverCollectionType<T>>`. A good place to start is `LoadableDetachableModel`, which you should try extending.  Also, see [UI-Models](UI-Models.html) for more information on `LoadableDetachableModel` and its caveats.

## Renderers

Renderers offer a way to build a non-HTML (plain text) string from a given `Collection<T>` or `IModel<? extends Collection<T>>`.

### When to use it

You should use renderers when:

 * Your expected output has a very simple structure
 * Your expected output does not require HTML (be warned that this excludes any kind of line break, since this would require a `<br>` or `<p>`)
 * Requirements are very unlikely to change in the future to require HTML inside the output

If you need more complex output, go for the [DataTableBuilder](#datatablebuilder) or [RefreshingViews](#refreshingviews).

### Examples

#### Building the renderer

```java
Renderer<Iterable<? extends MyItem>> collectionRenderer = Renderer.fromJoiner(
		Joiners.Functions.onComma(),
		MyItemRenderer.get()
);
```

#### Using the renderer

##### In a label

```java
IModel<Set<MyItem>> myModel = /* ... */;
add(new CoreLabel("id", collectionRenderer.asModel(myModel))); // Will display "item1, item2, item3"
```

#### In a StringResourceModel

`*.properties`:

```
my.resource.key=List value: {0}
```

Java:
```java
IModel<Set<MyItem>> myModel = /* ... */;
IModel<String> stringModel = new StringResourceModel("my.resource.key")
		.setParameters(collectionRenderer.asModel(myModel));
add(new CoreLabel("id", stringModel))); // Will display "List value: item1, item2, item3"
```

#### In an error message

Just use `Component.getString()` as follows:

```java
IModel<Set<MyItem>> myModel = /* ... */;
component.error(component.getString("my.resource.key", collectionRenderer.asModel(myModel)); // Will display "List value: item1, item2, item3"
```

And define your properties as follows:

```
my.resource.key=List value: ${}
```

## DataTableBuilder

The DataTableBuilder offers the simplest way to build a HTML table, quick & clean.

### When to use it?

In order to use DataTableBuilers, the component you want to build must meet the following requirements:

 * The expected output must be a HTML table
 * The data source must be some kind of collection of elements (a `IDataProvider`, a `IModel<? extends Collection<?>>` or a `ISequenceProvider`)
 * There must be one row in the table's body for each element in the data model (paging aside)
 * There must be a pre-defined, static maximum number of columns. Some columns may get hidden dynamically. For instance, you can't have one column for each element of an `IModel<? extends Collection<?>>` if this model's content may change between ajax refreshes.

If all of the above seems fine to you, then go ahead with the `DataTableBuilder`. Otherwise, you may still use [RefreshingViews](#refreshingviews).

### Overview

The general pattern for building a data table is as follows:

 * create a builder through one of the static `start` methods
 * add a column though one of the `.add*Column` methods, defining in particular the data to be displayed (with a binding or a `Function`)
 * customize the column though the various methods allowing to add CSS classes on cells, to add a link for each row, to add a sort-switching link in the header, and so on
 * repeat the same operations for each column
 * optionally, call `.decorate` in order to create a table with an upper title and pagers, or `.bootstrapPanel` to the the same in a Bootstrap panel
 * call `.build("wicketId")` in order to retrieve the resulting component.

Here is a (simple) example of use of `DataTableBuilder`:

```java
DecoratedCoreDataTablePanel<?, ?> results =
		DataTableBuilder.start(dataProvider, dataProvider.getSortModel())
		.addLabelColumn(new ResourceModel("business.customer.lastName"), Bindings.customer().lastName())
				.withLink(CustomerDescriptionPage.MAPPER)
				.showPlaceholder()
				.withSort(CustomerSort.LASTNAME, SortIconStyle.ALPHABET, CycleMode.NONE_DEFAULT_REVERSE)
				.withClass("text text-sm")
		.addLabelColumn(new ResourceModel("business.customer.firstName"), Bindings.customer().firstName())
				.withLink(CustomerDescriptionPage.MAPPER)
				.showPlaceholder()
				.withSort(CustomerSort.FIRSTNAME, SortIconStyle.ALPHABET, CycleMode.NONE_DEFAULT_REVERSE)
				.withClass("text text-sm")
		.addLabelColumn(new ResourceModel("business.customer.birthdate.short"), Bindings.customer().birthdate(), DatePattern.REALLY_SHORT_DATE)
				.showPlaceholder()
				.withSort(CustomerSort.BIRTHDATE, SortIconStyle.DEFAULT, CycleMode.NONE_DEFAULT_REVERSE)
				.withClass("date date-xs")
				.withClass(ResponsiveHidden.XS_AND_LESS)
		.addBootstrapLabelColumn(new ResourceModel("business.customer.status"), Bindings.customer().status(), CustomerStatusRenderer.get())
				.withClass("statut statut-md")
				.withClass(ResponsiveHidden.XS_AND_LESS)
		.addLabelColumn(new ResourceModel("business.customer.sector.short"), Bindings.customer().sector())
				.showPlaceholder()
				.withClass("code code-sm")
				.withClass(ResponsiveHidden.XS_AND_LESS)
		.decorate()
				.count("customer.list.result.count")
				.ajaxPagers()
		.build("results");
```

### Data source

You may provide either a `ISequenceProvider` or a `IDataProvider` to the `start` method as a data source. The resulting data table will contain exactly one row for each element provided by your data source.

### Supported column types

Here is a list of the built-in column types:

 * Label columns (`addLabelColumn`), which display a simple textual label derived from the underlying value (through the use of a [Renderer](Renderer.md)). Optionally, the label may be wrapped in a link, or have a side link (a link on a side button) appended.
 * Bootstrap label columns (`addBootstrapLabelColumn`), which display a textual label with a background color and prepended icon that all depend on the underlying value. Optionally, the label may be wrapped in a link, or have a side link (a link on a side button) appended.
 * Bootstrap badge columns (`addBootstrapBadgeColumn`), which display a badge with a background color and an icon that depend on the underlying value. Optionally, the label may be wrapped in a link, or have a side link (a link on a side button) appended.
 * Action columns (`addActionColumn`), which display one or more buttons, each button being either:
  * A link to a bookmarkable page
  * An action link: a link which will trigger execution of arbitrary code (with or without a confirmation popup)
  * An **ajax** action link (with or without a confirmation popup)

If none of the above suits your needs, keep in mind that you may simply use the `fr.openwide.core.wicket.more.markup.repeater.table.builder.DataTableBuilder.addColumn(ICoreColumn<T, S>)` method and pass your own column implementation as a parameter. Most of the time, you will simply have to extend `fr.openwide.core.wicket.more.markup.repeater.table.column.AbstractCoreColumn<T, S extends ISort<?>>` and implement `populateItem(Item<ICellPopulator<T>>, String, IModel<T>)` so as to add a `Fragment` defined in your own component.

#### Adding components around the table

##### Super headers

You may add arbitrary rows above or below the data table by calling `addTopToolbar` or `addBottomToolbar` and then adding components, optionally attributing a colspan to each of them.
This is great in particular if you want to add headers that span multiple columns above your column headers.

##### Simple title and pager

You may create a "decorated" table, with a top title and pagers, by calling `decorate` after having defined your columns. You may then define the title (optionally making it dependent on the result count, by calling `count`), add top and/or bottom pagers (`.pagers`, `.ajaxPagers`, ...), or even add arbitrary add-ins (`.addIn`).

##### Bootstrap panel

You may create a "decorated" table as above, but with Bootstrap styling, wrapped in a Bootstrap panel. Just call `bootstrapPanel` instead of `decorate`, and proceed the same as with `decorate`.

## RefreshingViews

Compared to the `DataTableBuilder`, the `RefreshingView`s are a lower-level way of displaying collections.

### When to use it?

Whenever you can't use the `DataTableBuilder`:

 * You don't want a HTML table, but just some repeating `div`s or `li`s (or any other markup, really)
 * You want a HTML table, but it's too complex and can't be built using the `DataTableBuilder`. For example you may need multiple `<tr>` for each element in your collection, or you may need to repeat columns instead of rows.

### Overview

`RefreshingView`s are generally used this way:

Panel's HTML:

```html
...

<div wicket:id="item">
	<span wicket:id="content1" />
	<wicket:container wicket:id="content2" />
</div>
...
```

Panel's Java:

```java
add(new SubclassOfRefreshingView<MyItem>("item", dataProvider) {
	@Override
	public void populateItem(final Item<MyItem> item) {
		item.add(new Label("content1", new ResourceModel("some.resource.key"));
		item.add(new SomePanel("content2", item.getModel());
	}
})
```

### Which view to use?

It depends on you data source:

 * for a `IDataProvider`, use a `SequenceView` (or wicket's `DataView`, which for now should do the same job, but may not gain as much features as SequenceView in the future).
 * for a `ISequenceProvider`, use a `fr.openwide.core.wicket.more.markup.repeater.sequence.SequenceView`
 * for a `ICollectionModel<T, ?>`, use a `fr.openwide.core.wicket.more.markup.repeater.collection.CollectionView`.
 * for a `IMapModel<K, V, ?>`, use a `fr.openwide.core.wicket.more.markup.repeater.map.MapView`.
 * for a `IModel<? extends Collection<T>>`, use a `fr.openwide.core.wicket.more.markup.repeater.collection.CollectionView`. You will need to provide a factory for the collection item models. (see [below](#item-models)).
 * for a `IModel<? extends Map<K, V>>`, use a `fr.openwide.core.wicket.more.markup.repeater.map.MapView`. You will need to provide a factory for the map key models (see [below](#item-models)).

Please note that all of the above provide a paging mechanism, but it will only be efficient if your data source is a properly implemented `IDataProvider` or `ISequenceProvider`. Otherwise, the whole data set will be loaded, and then reduced to the current page's data.

### Item models

The `RefreshingView`s need to obtain a reference to the collection's item model, in order to handle manipulations of this item (for instance, a click on a button in a table row mapped to an item).

The way you will implement the "item model factory" will depend on your data source:

 * With Wicket's built-in `IDataProvider`, the `IDataProvider` itself will provide the item model through its `model(T)` method. This method is the "item model factory".
 * With OWSI-Core's `ISequenceProvider` the provided items are already wrapped in models: the `iterator(long, long)` method returns an `Iterator<? extends IModel<T>>`. The `ISequenceProvider` itself is the "item model factory". This also applies to `ICollectionModel` and `IMapModel`.
 * With an `IModel<? extends Collection<T>>` (be it a `LoadableDetachableModel`, a `BindableModel`, or anything else), nothing in the data source itself allows to build item models. That's why most views defined above require you to provide a `Function<? super T, ? extends IModel<T>>` that will serve as an "item model factory".

When a `Function<? super T, ? extends IModel<T>>` is required, you may:

 * Use `GenericEntityModel.factory()` if your items are `GenericEntity`s
 * Use `Models.serializableModelFactory()` if your items are serializable (`Integer`, `String`, enums, ...)
 * Define your own function if none of the above suits your needs. Take care to make the `Function` also implement `Serializable`, since it will be serialized with the page after the response.

## For more advanced needs

Wicket also offers various types of built-in `RepeatingViews`s, but the above should encompass most common needs. Only use these views as a fallback if the above clearly won't do.

### `ListView` and `IndexedItemListView`

The main advantage of `ListView` is that you don't need to define a specific model for the collection items: they are (by default) mapped by their index to the collection model.

**Be warned**, though, that with this mechanism, you may run into issues if you implement user operations on the element's models (like opening a modal, or removing an element) and if your underlying collection's content changes between the initial page rendering and the user request: the operation may end up being executed on the wrong item (because the index may not point the the same collection element anymore).

`ListView` and `IndexedItemListView` should be used very rarely, and only if you really know what you're doing.

### Adding or removing items using Ajax without refreshing the whole collection view

Wicket, by default, only allows to add or remove items using Ajax to a collection view by refreshing the whole view.

If, for some reason, you don't want to refresh pre-existing, unremoved items, you may use `fr.openwide.core.wicket.more.ajax.AjaxListeners.refreshNewAndRemovedItems(IRefreshableOnDemandRepeater)`:

```java
AjaxListeners.add(
		target,
		AjaxListeners.refreshNewAndRemovedItems(repeater)
);
```

There are some constraints, though:

 * `repeater` must implement `IRefreshableOnDemandRepeater` (that's the case for most view provided in OWSI-Core)
 * both the repeater's parent and the repeater's items must have `setOutputMarkupId` set to `true`
 * newly added items will be added at the end of the repeater's parent (the Wicket parent). If there is some HTML between the repeater and the end of the parent, you'll probably want to wrap your repeater in an `WebMarkupContainer`.
 * only some classes that implement `IRefreshableOnDemandRepeater` allow to detect removed elements, so only these will see their removed items removed from the HTML. `RepeatingView` and its subclasses, in particular, will not have their removed elements removed from the HTML.


## ~~`AbstractGenericItemListPanel`~~ and ~~`GenericPortfolioPanel`~~ (don't use this)

These classes should not be used anymore. Anything you can do with a `GenericPortfolioPanel`, you can also do it with a `DataTableBuilder` or (worst case) with `RefreshingView`s.

These classes are kept as-is in order to avoid major refactorings in older projects.
