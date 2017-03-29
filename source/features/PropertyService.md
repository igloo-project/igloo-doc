# PropertyService

## About

The PropertyService gets and sets the values for your application's properties in a typesafe manner.
These might be stored in `*.properties` files (being "immutable" properties) or in database ("mutable" properties).

## Architecture

Properties are referenced to using their *id*, which may have one of two types:

 * `ImmutablePropertyId` for immutable properties that are linked to <code>configuration.properties</code>.
 * `MutablePropertyId` for mutable properties that are stored in database in table <code>Parameter</code> as <code>String</code>. Beware that the other columns of this table are deprecated.

Here are the basic principles:

 * Properties are first registered using their ID during the application initialization. The registration involves telling to the `PropertyService` how to convert the property value to and from its string representation, which is done by providing a `Converter` (a Guava type), or (for immutable properties that don't need to be converter back to string) a `Function`.
 * During the execution of the application, the property values may be retrived using the service's `get` method, or altered using the `set` method.

## Using it in your application

### Declare the IDs

You must first declare constants for your property ids. You'd better have two sets of property ids: one for you core (non-UI) project and the other for you webapp (UI) project.

The keys passed as parameters to `AbstractPropertyIds`'s methods are the one used to retrieve the values, either in the `configuration.properties` file or in database.

```java
public final class YourAppCorePropertyIds extends AbstractPropertyIds {

	public static final ImmutablePropertyId<Integer> CORE_IMMUTABLE_INTEGER_PROPERTY = immutable("core.immutable.integer.property");
	public static final ImmutablePropertyId<MyType> CORE_IMMUTABLE_MYTYPE_PROPERTY = immutable("core.immutable.mytype.property");

	public static final MutablePropertyId<String> CORE_MUTABLE_STRING_PROPERTY = mutable("core.mutable.string.property");

}
```

```java
public final class YourAppWebappPropertyIds {

	public static final ImmutablePropertyId<Long> WEBAPP_IMMUTABLE_LONG_PROPERTY = immutable("webapp.immutable.long.property");
	public static final ImmutablePropertyId<MyType> WEBAPP_IMMUTABLE_MYTYPE_PROPERTY = immutable("webapp.immutable.mytype.property");

	public static final MutablePropertyId<String> WEBAPP_MUTABLE_STRING_PROPERTY = mutable("webapp.mutable.string.property");

}
```

### Register the properties

In your <code>core</code> module set up a JavaConfig as follows.

**Beware that `AbstractApplicationPropertyConfig` also declares the property service, which is a singleton**. Thus it must only be used once (in your core module).

```java
@Configuration
public class YourAppCoreApplicationPropertyConfig extends AbstractApplicationPropertyConfig {

	@Override
	public IMutablePropertyDao mutablePropertyDao() {
		return new ParameterDaoImpl();
	}

	@Override
	public void register(IPropertyRegistry registry) {
		// register core properties here
	}

}
```

In your <code>webapp</code> module set up a JavaConfig as follows:

```java
@Configuration
public class YourAppWebappApplicationPropertyRegisterConfig extends AbstractApplicationPropertyRegistryConfig {

	@Override
	public void register(IPropertyRegistry registry) {
		// register webapp properties here
	}

}
```

`IPropertyRegistry` provides a bunch of methods to register properties. See details below.

### Access the properties

Anywhere an `IPropertyService` is available (it can be injected), do the following:

```java
@Autowired
private IPropertyService propertyService;

// Get a value
propertyService.get(YourAppCorePropertyIds.CORE_IMMUTABLE_MYTYPE_PROPERTY);

// Set a value (only for mutable properties)
propertyService.set(YourAppCorePropertyIds.CORE_MUTABLE_STRING_PROPERTY, "NewValue");

```
## Details about registration

### Important note

It is strongly recommended to define a default value for collection properties in order to always get a collection even if the value is `null`.

### Examples

**Basic immutable property**
```java
public static final ImmutablePropertyId<String> MAINTENANCE_URL = immutable("maintenance.url");
```
```java
propertyService.registerString(MAINTENANCE_URL);
```
**Immutable property with custom converter/function**
```java
public static final ImmutablePropertyId<Date> DATE_PICKER_RANGE_MAX_DATE = immutable("datePicker.range.max.yearsFromNow");
```
```java
propertyService.registerImmutable(DATE_PICKER_RANGE_MAX_DATE, new Function<String, Date>() {
	@Override
	public Date apply(String input) {
		Integer years = Ints.stringConverter().convert(input);
		if (years == null) {
			return null;
		}
		return DateUtils.truncate(
				DateUtils.addYears(new Date(), years),
				Calendar.DAY_OF_MONTH
		);
	}
});
```
**Mutable property with dynamic key with default value**
```java
public static final MutablePropertyIdTemplate<Boolean> DATA_UPGRADE_DONE_TEMPLATE = mutableTemplate("dataUpgrade.%1s");
public static final MutablePropertyId<Boolean> dataUpgrade(IDataUpgrade dataUpgrade) {
	return DATA_UPGRADE_DONE_TEMPLATE.create(dataUpgrade.getName());
}
```
```java
propertyService.registerBoolean(DATA_UPGRADE_DONE_TEMPLATE, false);
```
**Property - enum**
```java
public static final ImmutablePropertyId<Environment> ENVIRONMENT = immutable("environment");
```
```java
propertyService.registerEnum(ENVIRONMENT, Environment.class, Environment.production);
```
**Property - collection**
```java
public static final ImmutablePropertyId<List<MediaType>> FICHIER_PIECE_JOINTE_MEDIA_TYPES = immutable("fichier.pieceJointe.mediaTypes");
```
```java
propertyService.register(FICHIER_PIECE_JOINTE_MEDIA_TYPES, new StringCollectionConverter<>(Enums.stringConverter(MediaType.class), Suppliers2.<MediaType>arrayList()));
```
