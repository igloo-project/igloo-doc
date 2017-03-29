# UI Models (TODO)

This page explains the Wicket concept of models and details various types of models that you might use in your applications.

## What is an `IModel`?

TODO

### Special cases

#### Collections

For details about how to display collections, and some tips about how to choose the correct interface for accessing you collection data, see [[UI-Displaying Collections]].

##### `IDataProvider`, `ISequenceProvider`

Both `IDataProvider` and `ISequenceProvider` are interfaces designed to provide access to large datasets, with built-in paging.

They

They mainly differ in the way they wrap elements into models. `IDataProvider` exposes a `Iterator<T> iterator(long, long)` method and a `IModel<T> model(T)` method that must be called by clients. This works, but causes trouble when `IDataProvider` implementor wants to always return the same model for the same element (for example because the model carries more mutable information than just a reference to the element).

`ISequenceProvider` solves the issue by directly returning a `Iterator<IModel<T>> iterator(long, long)`. This gives more flexibility to implementors and changes next to nothing (save the interface) for clients.

Please note that in most cases, you should not have to implement an `ISequenceProvider` yourself: simply implementing an `IDataProvider` should do the job. This interface is available for very specific features, such as those implemented in `CollectionCopyModel`.

##### `ICollectionModel`, `IMapModel`

Those interfaces are implemented by models that:

 * provide access to a collection or a map
 * implement `ISequenceProvider` so as to always return the same model to wrap the same collection/map element
 * optionally, provide write operations (`add`/`put`, `clear`, ...)

Those implementations are noteworthy:

 * `CollectionCopyModel`
 * `CollectionMapModel`
 * `ReadOnlyCollectionModel`
 * `ReadOnlyMapModel`

See below on this page for details.

## Main use cases

### `GenericEntityModel`

TODO

### `BindingModel`

TODO

### `IBindableModel` et al.

#### The use case: inter-dependent form components

When designing complex forms, often we have to update some parts of the form whenever a given field changes, even before the form was submitted. This may happen for instance:

 * Because some field's proposed values depend on another field's value
 * Because of some read-only panel must dynamically display detailed information about a selected value

In any case, you've got what we will call "source" form components (the ones whose value another component depends on) and "target" components (the ones which depend on another form component's value).

That kind of feature is generally achieved by adding an Ajax behavior on the source component that will update the underlying model whenever a client-side change occurs, and refresh the target components.

#### Why caches are needed

Most of the time, the underlying model is a `BindingModel`, and its root model is a `GenericEntityModel`, which means that the updated value may not be correctly saved for the next requests:

 * If the root object (the one we extract the property value from) is an unpersisted entity, then the updated value will be serialized with this unpersisted entity, which might not be a good idea (for instance if the value is itself an entity).
 * If the root object is a persisted entity, then on the next request, the root will be loaded from the database and will thus have its properties reset.

In the particular case where each "target" component depends on only one "source" component, and no other Ajax refreshes are performed, then it's fine, because we won't need the updated value again.

**But** let's say one "target" component depends on multiple "source" components, say `C` depends on `A` and `B`. We've got the following code:


```
// DON'T DO THIS, IT WON'T WORK AS EXPECTED

IModel<MyEntity> rootModel = /* ... */;
IModel<MyEntity2> propertyAModel = BindingModel.of(rootModel, Bindings.myEntity().propertyA());
IModel<MyEntity3> propertyBModel = BindingModel.of(rootModel, Bindings.myEntity().propertyB());

Form<?> form = new Form<>("form");
final MyDependingComponent depending = new MyDependingComponent("depending", propertyAModel, propertyBModel);
form.add(
		new MyEntity2DropDownChoice("propertyA", propertyAModel)
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						// THIS MAY FAIL, because B's value may not be up-to-date
						target.add(depending);
					}
				}),
		new MyEntity3DropDownChoice("propertyB", propertyBModel, String.class),
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						// THIS MAY FAIL, because A's value may not be up-to-date
						target.add(depending);
					}
				}),
		depending
);
```

Then the following scenario may fail:

 * `A` is modified by the user
 * The Ajax behavior updates `A`'s model and refreshes `C`, which will use `A`'s *updated* value and `B`'s *initial* value. So far so good.
 * `B` is modified by the user
 * The Ajax behavior updates `B`'s model and refreshes `C`. **`C` will use a wrong value for `A`:**
   * If `A`'s model is a `BindingModel` for an entity property whose root model is a `GenericEntityModel` holding an *unpersisted* entity, **C will use a serialized entity for `A`'s value, which may throw `LazyInitializationException`s whenever we try to access its properties**.
   * If `A`'s model is a `BindingModel` for an entity property whose root model is a `GenericEntityModel` holding a *persisted* entity, **C will use `A`'s initial value**.

#### How `IBindableModel`s solve the problem

Enter `IBindableModel`. The idea is to wrap the root model in a `IBindableModel`, and then only use this model's methods to access property models, which will have their values cached transparently.

So instead of the snippet of code above, we will do this:

```
IModel<MyEntity> rootModel = /* ... */;
IBindableModel<MyEntity> bindableRootModel = BindableModel.of(rootModel);
IModel<MyEntity2> propertyAModel = bindableRootModel.bindWithCache(Bindings.myEntity().propertyA(), new GenericEntityModel<Long, MyEntity2>());
IModel<MyEntity3> propertyBModel = bindableRootModel.bindWithCache(Bindings.myEntity().propertyB(), new GenericEntityModel<Long, MyEntity2>());

Form<?> form = new CacheWritingForm<>("form", bindableRootModel); // Necessary so the caches are written to the object when submitting
final MyDependingComponent depending = new MyDependingComponent("depending", propertyAModel, propertyBModel);
form.add(
		new MyEntity2DropDownChoice("propertyA", propertyAModel)
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						target.add(depending);
					}
				}),
		new MyEntity3DropDownChoice("propertyB", propertyBModel, String.class),
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						target.add(depending);
					}
				}),
		depending
);
```

That way, the values used by `depending` are those in `propertyAModel` and `propertyBModel`'s caches, and those are always clean and up-to-date.

If you must make `MyDependingComponent` use a `MyEntity` model instead of a `MyEntity2` model and a `MyEntity3` model, and only use these properties indirectly (for instance because you must call a service wich accept a `MyEntity` parameter), then you can make use of the `IBindingModel#writeAll()` method, which forces the writing of caches to the underlying entity:

```
IModel<MyEntity> rootModel = /* ... */;
final IBindableModel<MyEntity> bindableRootModel = BindableModel.of(rootModel);
IModel<MyEntity2> propertyAModel = bindableRootModel.bindWithCache(Bindings.myEntity().propertyA(), new GenericEntityModel<Long, MyEntity2>());
IModel<MyEntity3> propertyBModel = bindableRootModel.bindWithCache(Bindings.myEntity().propertyB(), new GenericEntityModel<Long, MyEntity2>());

Form<?> form = new CacheWritingForm<>("form", bindableRootModel); // Necessary so the caches are written to the object when submitting

// MyDependingComponent depends on a IModel<MyEntity>, and only indirectly uses propertyA and propertyB
final MyDependingComponent depending = new MyDependingComponent("depending", bindableRootModel);
form.add(
		new MyEntity2DropDownChoice("propertyA", propertyAModel)
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						bindableRootModel.writeAll();
						target.add(depending);
					}
				}),
		new MyEntity3DropDownChoice("propertyB", propertyBModel, String.class),
				.add(new AjaxFormComponentUpdatingBehavior() {
					protected void onUpdate(AjaxRequestTarget target) {
						bindableRootModel.writeAll();
						target.add(depending);
					}
				}),
		depending
);
```

#### Do's and don'ts

##### Declare your caches

Caches must be declared explicitly:

 * call `IBindableModel.bindCollectionWithCache()` on any collection property whose elements may have their properties written to.
 * call `IBindableModel.bindMapWithCache()` on any map property whose keys or values may have their properties written to.
 * call `IBindableModel#bindWithCache(<binding>, <cache model>)` on any property which both read from (by depending components) and written to (by a `FormComponent` for instance).

##### Don't mix `BindingModel`s with `IBindableModel`s

Using a `BindingModel` with a `IBindableModel` as root model will result in bypassing the `IBindableModel`'s cache (if any). You may then witness some strange behaviors due to your `BindableModel` returning a stale value.

Thus, if you use `IBindableModel`, stick with it. If you must pass a model to a child component, check that this child component doesn't use `BindingModel`s.

If you really must use a component that uses `BindingModel`s internally, you can, but only if it's read-only (i.e. it doesn't wraps `FormComponent`s). **Keep in mind**, though, that you must explicitly write the caches to your business objects whenever you do an Ajax refresh.

##### Write caches to your business objects before using them

Caches are not written magically to your business objects. Thus:

 * When your form is being submitted and after it has written the submitted values to your models (to your caches, actually), you must ensure that the caches are actually written to the actual properties so that the root object is fully updated.

    Luckily for you, `CacheWritingForm` does exactly that. Just use it as your root form and, if all of your `IBindableModel`s are children of your root model, then they will all be updated upon submit.
 * Whenever you do handle events (`Link`s, `AjaxLink`s, ajax behaviors, ...), if any treatment bypasses the `IBindableModel` and reads directly from the business objects (e.g. `bindableRootModel.getObject().getPropertyA()` instead of `bindableRootModel.bind(Bindings.myEntity().propertyA()).getObject()`), then you should call `IBindableModel#writeAll()` beforehand.

##### Read caches from your business objects when you modify objects directly

Caches are not updated magically when you bypass the `IBindableModel` and write to the properties directly (e.g. `bindableRootModel.getObject().setPropertyA(<something>)` instead of `bindableRootModel.bind(Bindings.myEntity().propertyA()).setObject(<something>)`).

If you have to do such things, make sure that you call `IBindableModel#readAllUnder()` afterwards.

### `CollectionCopyModel` and `MapCopyModel`

`CollectionCopyModel` and `MapCopyModel` are simply put, models to store your collections or maps directly in your page, with no persistence.

They provide two main features:

 * they always copy the collection/map when `setObject` is called (hence the name). So even if some one calls `setObject` with an immutable collection as a parameter, the collection returned by `getObject` will still be mutable.
 * upon detach, they do not reference the collection or its elements directly, but they wrap the elements in models so that each element is detached correctly. This is especially useful when handling collections of `GenericEntity`, that should never be serialized with the page.

Both models require two things when they're created: a mean of instantiating a new empty collection/map (a `Supplier`), and a mean of instantiating the model that will wrap an element (a `Function<T, IModel<T>>`).

Here are some examples:

```java
ICollectionModel<?, Set<MyEntity>> myEntitySetModel =
		CollectionCopyModel.custom(Suppliers2.<MyEntity>hashSetAsSet(), GenericEntityModel.<MyEntity>factory())
```

```java
ICollectionModel<?, SortedSet<MyEnum>> myEnumSortedSetModel =
		CollectionCopyModel.serializable(Suppliers2.treeSetAsSortedSet(MyEnumComparator.get()));
```

```java
IMapModel<?, ?, Map<MyEntity, String>> myEntityToStringModel = MapCopyModel.custom(
		Suppliers2.<MyEntity, String>hashMapAsMap(),
		GenericEntityModel.<MyEntity>factory(),
		Models.<String>serializableModelFactory()
);
```

### `AbstractReadOnlyModel`

TODO

### `LoadableDetachableModel` and `LoadableDetachableDataProvider`

`LoadableDetachableModel` and `LoadableDetachableDataProvider` are two abstract classes that provide a caching feature, so that the data they give access to is "loaded" on the first access, cached, and then returned as it was retrieved on the first access on every subsequent call, until `detach` is called.

This avoids repeated calls to the database during a single request/response cycle.

#### Caching

As said above, `LoadableDetachableDataProvider` and `LoadableDetachableModel` will only execute the underlying query once per HTTP request, even if their data-access methods (`count`, `iterator`, `getObject`) are called multiple times. This is, in most cases, what you want.

However, in some very particular cases, you may have to first access the data source (`LoadableDetachableDataProvider` or `LoadableDetachableModel`), then change the underlying data (through a service call), then render the page. **Be warned** that in this case, the rendered data will be the data loaded before your change. If it's not what you want, then you should "refresh" the `LoadableDetachableXXX` explicitly by calling `detach()`.

#### Modifying data

As usual, modifying the entities retrieved from the `LoadableDetachableDataProvider` or `LoadableDetachableModel` won't alter the database: you need to make service calls in order for these changes to be persisted.

Another thing that might be obvious: be aware that calls to `LoadableDetachableModel.setObject()` will, by default, only change the model value for the current request/response cycle. This is normal, because only you know what to do in order to persist this change.

If you want to persist your changes in database, then you should provide a method in your service layers that will do the work.

If you just want a cache that spans multiple requests, then `CollectionCopyModel` or `MapCopyModel` might be what you're looking for. See further down this page for more information.

## Utilities

### CompositeSortModel

TODO

### `StreamModel`

`StreamModel` is made to manage Wicket models wrapping `Iterable`. A `StreamModel` is a read-only `IModel<Iterable<T>>`.

Use `StreamModel<T> mySteamModel = StreamModel.of(IModel<? extends Iterable<T>> model)` to get started. From there, you can :
 * Use it as a classic Wicket model : `mySteamModel.getObject()`.
 * Concatenate multiple models : `mySteamModel.concat(IModel<? extends Iterable<? extends T>> firstModel, IModel<? extends Iterable<? extends T>>... otherModels)`.
 * Transform (map) elements of the collection : `mySteamModel.map(Function<T, S> function)`.
 * Get a `IModel` which provides the elements in a specific collection type: `mySteamModel.collect(Supplier<? extends C> supplier)`
 * Combine all of the above : `mySteamModel.concat(IModel<? extends Iterable<? extends T>> firstModel, IModel<? extends Iterable<? extends T>>... otherModels).map(Function<T, S> function).collect(Supplier<? extends C> supplier)`

### `WorkingCopyModel`, `CollectionWorkingCopyModel` and `MapWorkingCopyModel`

These model wrap two other models: a reference model and a "copy" model. They delegate read and write access to the copy model, while providing additional methods to *write* from the copy to the reference and *read* from the reference to the copy.

These models should not be used directly as a more high-level feature is available with the `BindableModel` described above.

## Troubleshooting

Sometimes, you've got models that are not detached properly, but you simply don't know which ones. You just know that, on the next rendering of you page, everything explodes with a `org.hibernate.LazyInitializationException`. In that case, you've got to dig up a bit, and this chapter aims at helping you doing just that.

### Built-in logs

`GenericEntityModel` and `AbstractThreadSafeLoadableDetachableModel` (plus its subclasses) provide built-in logging when attached values are suspiciously serialized.

They show:

 * The currently attached value at WARN level
 * A stacktrace of the latest attach operation on this model at DEBUG level (don't use this level in production environment: it involves aggressive stacktrace recording)

### Breakpoints

If the above logs are not enough (and they should), you may still use breakpoints.

Just put your breakpoints inside the `if` in `GenericEntityModel#writeObject` or `AbstractThreadSafeLoadableDetachableModel#writeObject`. In the stack will appear several `writeObject0` methods: inspect those and the `arg0` parameter to determine the chain of objects that lead to the incorrect serialization of your model. You will then probably have to fix one of this object by adding a missing `detach` somewhere.
