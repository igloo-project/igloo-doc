# Migrating to 0.11

This guide aims at helping OWSI-Core users migrate an application based on OWSI-Core 0.9 to OWSI-Core 0.11.

OWSI-Core 0.10 was never released, so you should not have to migrate from this version, but if you did, then you could use this guide. Some parts would be irrelevant, but nothing should be missing.

Tools
-----

### Maven
Use the latest version of maven (at least Maven 3.3.1).

### Java
~~Use JDK8. Earlier versions won't work.~~ Actually, use JDK7. A frequent VM crash was spotted when using Java 8 on a 32-bit OS and a bug report is currently pending review.

### Bindings & code processors
You may have trouble with your bindings. Know that:

 1. QueryDSL completely revamped its bindings; you'll need to delete them completely and regenerate them.
 2. QueryDSL bindings generation will now fail if your project does not compile. Worse, not having QueryDSL bindings will add an enormous amount of build errors, which will make it much harder to spot actual errors that you must fix. It might be easier to first override QueryDSL's version and the processor used for QueryDSL bindings generation in your project (while sticking with OWSI-Core 0.9), and only then attempt migrating to OWSI-Core 0.11. The new processor is `com.querydsl:querydsl-apt` version 4.0.7. See below for changes in the new version of QueryDSL (`com.querydsl:querydsl-jpa` v4.0.7)
 3. [[This page|Code processors]] might help if you encounter errors when generating bindings.

A new feature was introduced in OWSI-Core 0.11 that allows the bindings to be completely wiped before generation, so that you won't need to manually delete them after a refactoring, for instance. In order to benefit from this feature, you must change your `eclipse/*.launch` files so that the invoked goals are simply `generate-sources`, but with the `eclipse-processor` profile enabled. On Linux, you may use the following command line from your project root:

```
find eclipse -name '*.launch' -print0 | xargs -0 sed -r -i 's/org.bsc.maven:maven-processor-plugin:process( org.bsc.maven:maven-processor-plugin:process-test)?/generate-sources/;s,<stringAttribute key="M2_PROFILES" value=""/>,<stringAttribute key="M2_PROFILES" value="eclipse-processor"/>,'
```

External changes (libraries)
----------------------------

### OpenCSV

 * The maven artifact has changed. `net.sf.opencsv:opencsv` is now `com.opencsv:opencsv`.
 * The main package changed, too. `au.com.bytecode.opencsv` is now `com.opencsv`.

### FlyingSaucer (XHtmlRenderer)

 * The renderer now supports border-radius. Please check that the rendering output in your project still suits you.

### QueryDsl
 * the root package has changed
 * the general logic is now `query.select(...).from(...).fetch()`
  * `count()` -> `fetchCount()`
  * `uniqueResult()` -> `fetchOne()`
  * `singleResult()` -> `fetchFirst()`
  * `fetch().fetchAll()` -> `fetchJoin().fetchAll()`
 * `query.map(keyExpression, valueExpression)` becomes `query.transform(GroupBy.groupBy(key).as(value))`
 * Be careful with `mapExpression.containsKey`. From QueryDSL 4 on (maybe before?), QueryDSL will *not* create a subquery, but instead will try doing a join in the main query, with mixed results (especially considering that Hibernate is notoriously buggy when it comes to cross-joins mixed with left/right/inner joins). To be safe, do not do this:

	```java
	new JPAQuery<MyEntity>(getEntityManager())
		.select(qMyEntity)
		.from(qMyEntity)
		.from(qMyOtherEntity)
		.where(qMyOtherEntity.mapProperty.containsKey(qMyEntity))
		.orderBy(qMyEntity.id.asc())
		.fetch();
	```

	But instead do this:

	```java
	new JPAQuery<MyEntity>(getEntityManager())
	.select(qMyEntity)
		.from(qMyEntity)
		.where(
				JPAExpressions.selectOne()
				.from(qMyOtherEntity)
				.where(qMyOtherEntity.mapProperty.containsKey(qMyEntity))
				.exists()
		)
		.orderBy(qMyEntity.id.asc())
		.fetch();
	```

### Hibernate

 * When using `javax.persistence.Index` with Hibernate, now the column names in columnList are *really* column names, not some mix-up of physical and logical names: if you had written myEmbeddable.myProperty_id, it becomes myEmbeddable_myProperty_id (or whatever name your column has)
 *  If you were using the deprecated datatype `org.hibernate.type.StringClobType`, then be sure to switch to `fr.openwide.core.jpa.hibernate.usertype.StringClobType` (as the former has been removed). Note that you may now use `fr.openwide.core.jpa.hibernate.usertype.StringClobType.TYPENAME` instead of duplicating the same inline String constant each time you need it.
 * The naming strategy system changed in Hibernate 5. You must now add this to your `configuration-private.properties`

	```
	hibernate.implicit_naming_strategy=fr.openwide.core.jpa.hibernate.model.naming.ImplicitNamingStrategyLegacyJpaComponentPathImpl
	hibernate.physical_naming_strategy=fr.openwide.core.jpa.hibernate.model.naming.PostgreSQLPhysicalNamingStrategyImpl
	hibernate.id.new_generator_mappings=false
	```

### Hibernate Search & Lucene
 * `SortField.STRING` is now `SortField.Type.STRING`
 * Dates are now stored as `Long` so you need to sort them using `Sort.Type.LONG`
 * Lucene has been upgraded. You will have to wipe clean your indexes and reindex everything
 * For any field on which you perform a sort, you should now use the `@SortableField` (or `@SortableFields`) annotation. This is not mandatory, but will offer better performance and avoid annoying logs.
   * Note that, to sort GenericEntities by ID, you should now use the `GenericEntity.ID_SORT` field (or you'll get annoying warnings in your logs).
 * The use of Lucene's `TokenStream` is now more safeguarded; this may lead to exceptions where you were not using it properly. Make sure that:
   * You always instantiate them in a try-with-resource (`try (TokenStream = /* ... */) { /* ... */ }`)
   * You always call `.reset()` before use
   * You always call `.end()` after use

### WiQuery

The project has been moved to [wicketstuff](https://github.com/wicketstuff/wiquery). Thus:

 * The maven artifacts have changed:
  * `org.odlabs.wiquery:wiquery-core` is now `org.wicketstuff.wiquery:wiquery-core`
  * `org.odlabs.wiquery:wiquery-jquery-ui` is now `org.wicketstuff.wiquery:wiquery-jquery-ui`
 * The main package changed, too. `org.odlabs.wiquery` is now `org.wicketstuff.wiquery`. If you're running an Unix-like OS, you may fix this in your project automatically with this command (to be run from the root of your project): `find . -name '*.java' | xargs sed -i 's/^import org.odlabs.wiquery/import org.wicketstuff.wiquery/'`

### Wicket

 * You no longer need to depend on `fr.openwide.core.components:000-owsi-core-component-wicket-override`. Plus, it will probably harm to do so. Just remove this dependency.
 * `StringResourceModel` now has a fluid API: you should use `setModel`, `setParameters` and `setDefaultValue`
 * You need to look for Ajax links whose markup is an `<a>` the click event is not blocked by Wicket anymore, which will result in a scroll to the top of the page each time the link is clicked. This is always true for Google Chrome, but only if there is a `href` attribute for Firefox. To avoid any kind of trouble, just follow the guidelines detailed [[here|UI-User-Actions#html-markup]].
 * There is now a high-level integration of JQPlot built in OWSI-Core. See [the docs](https://github.com/openwide-java/owsi-core-parent/wiki/UI-Charts-and-plots) or the [pull request](https://github.com/openwide-java/owsi-core-parent/pull/21) for more information.

### Spring & Spring Security

 * in `security-http`, `use-expressions` is now `true` by default. Thus, you have to use expressions like `hasRole('xxx')` and `permitAll` or define it explicitely to `false`. Be careful that the error is triggered only when you effectively access a secured page.
 * change the `-4.0.xsd` schema to `-4.2.xsd` (Spring namespaces)
 * change the `-3.2.xsd` schema to `-4.0.xsd` (Spring Security namespaces) - obviously, you need to follow the order
 * in **every** `security:http` (even those related to simple REST API calls), you need to add:

	```xml
	<security:headers disabled="true"/>
	<security:csrf disabled="true"/>
	```

Internal changes
----------------

### Core

 * @PermissionObject has been moved to package `fr.openwide.core.commons.util.security`. Run the following command from the root of your project to update your imports: `find . -type f -name '*.java' -print0 | xargs -0 sed -r -i 's/fr.openwide.core.jpa.business.generic.annotation.PermissionObject/fr.openwide.core.commons.util.security.PermissionObject/g'`
 * `TransactionSynchronizationTaskManagerServiceImpl` now executes `afterRollback` on tasks implementing it in **reverse** order. See https://github.com/openwide-java/owsi-core-parent/commit/b431545ce20c8c5a182617e7e93b9f044086d4b1

### Webapp

 * The JQPlot/WQPlot dependency has been moved to a separate module. If you were using JQPlot/WQPlot, add this to your webapp's dependencies:

   ```
		<dependency>
			<groupId>fr.openwide.core.components</groupId>
			<artifactId>owsi-core-component-wicket-more-jqplot</artifactId>
			<version>${owsi-core.version}</version>
		</dependency>
   ```
 * The `FormErrorDecoratorListener` has been pulled from various projects to OWSI-Core. Use OWSI-Core's version.
 * The `DataTableBuilder` and related classes have moved. You may use the following sed script to convert your source code. Just create a file, put the following snippet in there, then run `find . -type f -name '*.java' -print0 | xargs -0 sed -r -i -f ./thescriptfile`. Here's the content of this file:

	```
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.DecoratedCoreDataTablePanel/fr.openwide.core.wicket.more.markup.repeater.table.DecoratedCoreDataTablePanel/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.DecoratedCoreDataTablePanel.AddInPlacement/fr.openwide.core.wicket.more.markup.repeater.table.DecoratedCoreDataTablePanel.AddInPlacement/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.builder.DataTableBuilder/fr.openwide.core.wicket.more.markup.repeater.table.builder.DataTableBuilder/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.AbstractCoreColumn/fr.openwide.core.wicket.more.markup.repeater.table.column.AbstractCoreColumn/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.CoreDataTable/fr.openwide.core.wicket.more.markup.repeater.table.CoreDataTable/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.util.DataTableUtil/fr.openwide.core.wicket.more.markup.repeater.table.util.DataTableUtil/g
	s/fr.openwide.core.wicket.more.markup.html.repeater.data.table.util.IDataTableFactory/fr.openwide.core.wicket.more.markup.repeater.table.builder.IDataTableFactory/g
	```
 * The `DataTableBuilder` and related classes are now based on the `ISequenceProvider` instead of `IDataProvider`. You may still use `IDataProvider` as an input to the `DataTableBuilder` (it will be wrapped).
 * A new interface was introduced in order to address code execution in a wicket context: `IWicketContextExecutor`. Here are the main consequences to existing applications:
   * An object of type `IWicketContextExecutor` is now available in the Spring context. You may `@Autowire` it in your own beans, or redefine it by overriding `fr.openwide.core.wicket.more.config.spring.AbstractWebappConfig.wicketContextExecutor(WebApplication)` in your own webapp configuration.
   * Classes extending `AbstractWicketRendererServiceImpl`, `AbstractNotificationContentDescriptorFactory`, `AbstractNotificationUrlBuilderServiceImpl`, `AbstractNotificationPanelRendererServiceImpl` must now provide a `IWicketExecutor` to their super constructor and must not override `getApplicationName()` anymore.
   * Classes extending `AbstractBackgroundWicketThreadContextBuilder` should instead rely on a `IWicketContextExecutor`.

### External link checker

The external link checker now has its own Maven module. See [[ExternalLinkChecker]] if you use it in your app.

Related to the new `PropertyService`: you also have to use `JpaExternalLinkCheckerConfig` (import) in your app.

### Properties

Both immutable and mutable properties are now handled by `PropertyService`. See [[PropertyService]] to use it in your app.

 * `CoreConfigurer`: getter methods are deprecated and redirect to `propertyService`. Utility methods are also deprecated.
 * `AbstratParameterServiceImpl`: getter and setter methods are deprecated and redirect to `propertyService`. Utility methods are also deprecated.

**Important notes**
 * Properties wrapping a date (or a date time) and registered in `PropertyService` must respect the following format 'yyyy-MM-dd' (or 'yyyy-MM-dd HH:mm(:ss)'). See `StringDateConverter` and `StringDateTimeConverter`.
 * `ConfigurationLogger`: As previously it uses _propertyNamesForInfoLogLevel_ property but it is based now on `PropertyService`. That's why all the properties you want to display must be registered in the `PropertyService`.
 * To display a warning message in case of `null` value while retrieving a property, add the following entry in your log4j file: `log4j.logger.fr.openwide.core.spring.property.service.PropertyServiceImpl=DEBUG`.

#### 1st option: keeping the old school properties management

This case is not tested yet and is **not recommended**. Please, as much as possible, migrate to the `PropertyService`.

Get the latest version of both `CoreConfigurer` and `AbstractParameterServiceImpl` (+ `IAbstractParameterService`) from the previous version of OWSI-Core and bring back all methods and attributes needed in your own `YourAppConfigurer` and `ParameterServiceImpl` (+ `IParameterService`).

Also, in `YourAppCorePropertyConfig`, make sure the `mutablePropertyDao` method returns a `IParameterDao` and not simply a `IMutablePropertyDao`.

#### 2nd (better) option: migrating to PropertyService

See [[PropertyService]]

* Create a `YourAppCorePropertyIds` and a `YourAppApplicationPropertyConfig` in your `core` module.
* Create a `YourAppWebappPropertyIds` and a `YourAppApplicationPropertyRegistryConfig` in your `webapp` module.
* Register your properties.
* Deprecate everything in `YourAppConfigurer` and `ParameterServiceImpl`
* Fix all deprecated warnings caused by the configurer and the parameter service. See Javadoc on deprecated methods in OWSI-Core to make it easier.
* Remove `ParameterServiceImpl` and `IParameterService`.
* Remove everything from `YourAppConfigurer`.

### Audit

The audit classes have been removed.

You should either:

 * Copy the old Audit base classes in your own project
 * Or (better) use the brand-new HistoryLog framework. See [[HistoryLog & Audit]]

### PasswordEncoder

From now on, we use bcrypt method to encode new passwords. However, old passwords / hashes still use previous encryption method.

### SecurityPasswordRules

SecurityPasswordRules is now a builder and provide a `Set<Rule>`.

```java
SecurityPasswordRules
	.builder()
	.minMaxLength(..., ...)
	.forbiddenUsername()
	.rule(YourCustomRule())
	.build();
```

Also, replace `SecurityPasswordRules.DEFAULT `:

```java
SecurityPasswordRules
	.builder()
	.minMaxLength(User.MIN_PASSWORD_LENGTH, User.MAX_PASSWORD_LENGTH)
	.build();
```

Configuration
------------------

 * Ensure to give a value to notification.mail.recipientsFiltered property (true or false). If true, mail's recipients are replaced by notification.test.emails property's content
 * Replace this : `hibernate.search.analyzer=org.hibernate.search.util.impl.PassThroughAnalyzer` with this `hibernate.search.analyzer=org.apache.lucene.analysis.core.KeywordAnalyzer`
 * The content of configuration-private.properties should be:

	```
	hibernate.implicit_naming_strategy=fr.openwide.core.jpa.hibernate.model.naming.ImplicitNamingStrategyLegacyJpaComponentPathImpl
	hibernate.physical_naming_strategy=fr.openwide.core.jpa.hibernate.model.naming.PostgreSQLPhysicalNamingStrategyImpl
	hibernate.id.new_generator_mappings=false
	```

Database
------------

 * You may have missing columns in the tables mapped to your `GenericLocalizedGenericListItem` entities. Please check them out.
 * The position in `GenericLocalizedGenericListItem`s is not nullable anymore. Execute this for each table:

	```
	update XXX set position=0 where position is null;
	```

 * The hash generated for foreign key constraints name has changed. Therefore, you will probably end up with duplicate foreign keys. After checking that this is effectively the case, you can use the following query to generate a cleanup script:

	```sql
	SELECT
		'ALTER TABLE ' || pclsc.relname || ' DROP CONSTRAINT ' || pc.conname || ';'
	FROM
		(
		SELECT
			 connamespace,conname, unnest(conkey) as "conkey", unnest(confkey)
			  as "confkey" , conrelid, confrelid, contype
		 FROM
			pg_constraint
		) pc
		JOIN pg_namespace pn ON pc.connamespace = pn.oid
		-- and pn.nspname = 'panmydesk4400'
		JOIN pg_class pclsc ON pc.conrelid = pclsc.oid
		JOIN pg_class pclsp ON	  pc.confrelid = pclsp.oid
		JOIN pg_attribute pac ON pc.conkey = pac.attnum	and pac.attrelid =	   pclsc.oid
		JOIN pg_attribute pap ON pc.confkey = pap.attnum and pap.attrelid = pclsp.oid
	WHERE pc.conname ilike 'fk\_%' or pc.conname ilike '%_fkey'
	ORDER BY pclsc.relname;
	```
 * The hash generated for unique constraints name has changed when using table level annotation (```uk_mykeyhash``` becomes ```ukmykeyhash```). Therefore, you will probably end up with duplicate unique constraints. After checking that this is effectively the case, you will need to identify them and create a cleanup script. To identify these constraints, you should search for ```@UniqueConstraint``` annotation references in your project.
 * If the application is old, you might even have a third naming scheme which you can detect with the following query:

	```sql
	SELECT
		'ALTER TABLE ' || pclsc.relname || ' DROP CONSTRAINT ' || pc.conname || ';'
	FROM
		(
		SELECT
			 connamespace,conname, unnest(conkey) as "conkey", unnest(confkey)
			  as "confkey" , conrelid, confrelid, contype
		 FROM
			pg_constraint
		) pc
		JOIN pg_namespace pn ON pc.connamespace = pn.oid
		-- and pn.nspname = 'panmydesk4400'
		JOIN pg_class pclsc ON pc.conrelid = pclsc.oid
		JOIN pg_class pclsp ON  pc.confrelid = pclsp.oid
		JOIN pg_attribute pac ON pc.conkey = pac.attnum	and pac.attrelid = pclsc.oid
		JOIN pg_attribute pap ON pc.confkey = pap.attnum and pap.attrelid = pclsp.oid
	WHERE char_length(pc.conname) = 18 and pc.conname ilike 'fk%'
	ORDER BY pclsc.relname;
	```

Wicket Resource Security
------------------------

Until now security context was not set in Wicket Resource because we used this snippet:

```xml
<security:http pattern="/wicket/resource/**" security="none" />
```

However, since `DropDownChoice` may now use Wicket Resources to fetch data:

1. We need a security context for some of the resources (e.g. to retrieve current authenticated user, or to prevent some users to access that resource)
2. We need to take care of which resources are publicly accessible

That's why you should now use `intercept-url` to protect resources. Add something like this before your default `security:http`:

```xml
	<!-- An entry point to respond with a 403 error if Spring Security wants the user to log in.
		Useful in situations where loging in is not an option, such as when serving CSS.
	 -->
	<bean id="entryPoint403" class="org.springframework.security.web.authentication.Http403ForbiddenEntryPoint"/>

	<security:http request-matcher="regex"
			pattern="^/wicket/resource/.*"
			create-session="never" entry-point-ref="entryPoint403" authentication-manager-ref="authenticationManager"
			auto-config="false" use-expressions="true">
		<security:headers disabled="true"/>
		<security:csrf disabled="true"/>

		<security:intercept-url pattern="^/wicket/resource/fr.openwide.core.basicapp.web.application.common.template.js.[^/]+.*" access="hasRole('ROLE_ANONYMOUS')" />
		<security:intercept-url pattern="^/wicket/resource/fr.openwide.core.basicapp.web.application.common.template.styles.[^/]+.*" access="hasRole('ROLE_ANONYMOUS')" />
		<security:intercept-url pattern="^/wicket/resource/fr.openwide.core.basicapp.web.application.common.template.images.[^/]+.*" access="hasRole('ROLE_ANONYMOUS')" />
		<security:intercept-url pattern="^/wicket/resource/fr.openwide.core.basicapp.web.application.[^/]+.*" access="hasRole('ROLE_AUTHENTICATED')" />
		<security:intercept-url pattern="^/wicket/resource/.*" access="hasRole('ROLE_ANONYMOUS')" />
	</security:http>
```

Please note that, if you have to make some other resources publicly available (for example on the login page), you should change the above to suit your needs. As is, only JS files, CSS files, static image files and Resources defined in packages other than those of your app (OWSI-Core, various dependencies like Select2) are made publicly available.

Ajax confirm link builder
----------------------------

 * `AjaxConfirmLink#build(String)` and `AjaxConfirmLink#build(String, IModel<O>)` no longer exist. Use `AjaxConfirmLink#build()` instead.
 * `AjaxConfirmLinkBuilder#create()` no longer exists. Use `AjaxConfirmLinkBuilder#create(String)` or `AjaxConfirmLinkBuilder#create(String, IModel<O>)`.
 * `AjaxConfirmLinkBuilder#onClick(SerializableFunction<AjaxRequestTarget, Void>)` and `AjaxConfirmLinkBuilder#onClick(AjaxResponseAction)` no longer exist. Use `AjaxConfirmLinkBuilder#onClick(IOneParameterAjaxAction<IModel<O>>)` or `AjaxConfirmLinkBuilder#onClick(IAjaxAction)` (no parameters) instead. You can use `AbstractAjaxAction` or `AbstractOneParameterAjaxAction`.
