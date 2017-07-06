# Migrating to 0.14

This guide aims at helping OWSI-Core users migrate an application based on OWSI-Core 0.13 to OWSI-Core 0.14.

**In order to migrate from an older version of OWSI-Core, please refer to [Migrating to 0.13](Migrating-to-0.13.html) first.**

Java
----

This version only supports **Java 8**.

External changes (libraries)
----------------------------

### Poi

 * `HSSFColor.WHITE.index` is now `HSSFColorPredefined.WHITE.getIndex()`.

### Spring & Spring Security

* `isTrue(boolean)` from the type Assert is now `isTrue(boolean, String)` with String = the exception message to use if the assertion fails.
* `notNull(boolean)` from the type Assert is now `notNull(boolean, String)` with String = the exception message to use if the assertion fails.

For the upgrade of Spring Security we had to update the schema from `spring-security-4.1.xsd` to `spring-security-4.2.xsd`.

### Guava

 * `CharMatcher.WHITESPACE` is now `CharMatcher.whitespace()`.

### Hibernate

 * `session.setFlushMode(FlushMode)` is now `session.setHibernateFlushMode(FlushMode)`.
 * `SessionImplementor` class is replaced by `SharedSessionContractImplementor` class.

The AvailableSettings libray now is `org.hibernate.cfg.AvailableSettings` instead of `org.hibernate.jpa.AvailableSettings`.
 * `AvailableSettings.SHARED_CACHE_MODE` is now `AvailableSettings.JPA_SHARED_CACHE_MODE`.
 * `AvailableSettings.VALIDATION_MODE` is now `AvailableSettings.JPA_SHARED_CACHE_MODE`.

The EmbeddableTypeImpl library is now `org.hibernate.metamodel.internal.EmbeddableTypeImpl` instead of `org.hibernate.jpa.internal.metamodel.EmbeddableTypeImpl`.

The upgrade of hibernate-core forced us to explicitly specify the **default_schema** for the database.
Every tables are created in this schema and it is no longer based on the search_path from PostgreSQL
configuration.

By default, default_schema = db_user. If you need to change it, you have to add the variable
`hibernate.defaultSchema` in `owsi-core-component-jpa.properties` and its value will override
the default value.

Class `PostgresqlSequenceStyleGenerator` is renamed `PerTableSequenceStyleGenerator`
as it is not postgresql-related; class content is unchanged. If you use it,
just retarget the new class.


### Hibernate Search

#### Hibernate Search & Lucene

We have upgraded Hibernate Search to the 5.7.0.Final which is not yet compatible
with Lucene 6 but requires at least Lucene 5.5.X so we have upgraded Lucene to the
5.5.4 version.

The utilization of `setBoost(float)` and `getBoost()` directly to a Query is now
deprecated. Instead we use the type `BoostQuery` to apply boost.

##### Configuration

 * The `ExplicitJpaConfigurationProvider` class no longer exists, all the configuration is now exclusively provided
 by the `DefaultJpaConfigurationProvider` class.


##### Behavior checking

Some structural changes are done so that old applications are not broken. Make
sure that expected behavior is still here:

 * **Hibernate:** database's sequence is now handled with the *new-style*
   hibernate configuration. Verify that the sequence are style named
   *table_pk_seq*. Give a special attention to your specialized configurations:
   * ensure that *hibernate.id.new_generator_mappings=true* (if you do not
     override this setting, it is fine)
   * custom *@GeneratedValue.strategy()*
   * custom *@GeneratedValue.generator()*
   * custom *@SequenceGenerator*
   * custom *@GenericGenerator*


#### Hibernate Search & ElasticSearch

You can now choose between Lucene and ElasticSearch for your Hibernate Search requests.
In order to do use ElasticSearch, you have first to install ElasticSearch 2.4.

Secondly, you have to specify 3 things in the file **app-core/configuration.properties** :
````
##
## Hibernate search Elasticsearch
##
hibernate.search.elasticsearch.enabled=true
hibernate.search.default.elasticsearch.host=http://127.0.0.1:9310
hibernate.search.default.elasticsearch.index_schema_management_strategy=CREATE
````
You have to set the first line value to `true` to enable ElasticSearch.
The second line is the address of your installed ElasticSearch, and finally the
third line is schema management strategy.


#### Lucene and ElasticSearch analyzers

Now that the analyzers are changing when you switch between Lucene and ElasticSearch,
they are no longer in the annotation form in the class `Parameter.java`. You can
find them respectively in `CoreLuceneAnalyzersDefinitionProvider.java` and `CoreElasticSearchAnalyzersDefinitionProvider.java`.

Due the exportation of analyzers definitions in external separate classes, you
can add your own analyzers definitions by extending one of these two classes and
override the function `register`.
After that, you have to add a property in the file `hibernate-extra.properties`
(create this file if it doesn't exists). If you want to use your own ElasticSearch
analyzers add this line :
```
hibernate.search.elasticsearch.analyzer_definition_provider=package.to.yourclass.ClassName
```
If you want to use your own Lucene analyzers add this line :
```
hibernate.search.lucene.analyzer_definition_provider=package.to.yourclass.ClassName
```

Note that when you choose to use ElasticSearch, Lucene's analyzers definitions are
still instanciated but only used internally.


#### Date SortField and ElasticSearch

[related commit](https://github.com/openwide-java/owsi-core-parent/commit/01cc888cb8f314554263d13bc76821c9f57a907d)

In ElasticSearch, Date SortField is of type STRING, but with Lucene, it is of
type LONG. If you perform sort with ``FullTextQuery.setSort(Sort sort)`` with a
Date field configured for one of the backends, it'll throw an exception with the
other backend.

 * **Solution 1:** Use only one backend, and initialize correctly and statically
   needed SortFields
 * **Solution 2:** Use QueryBuilder to build your Sort object. QueryBuilder use
   field metadata to determine the right type to use.
   * ``fr.openwide.core.jpa.search.util.SortFieldUtil`` provides examples on the
     ways to obtain a Sort object or to perform a setSort(...) that use
     QueryBuilder and circumvent this issue.
   * replacing FullTextQuery.setSort(Sort sort) by SortFieldUtil.setSort(...)
     can be done quickly
   * beware that this workaround use field metadata to determine the right
     type; not deterministic and silent errors may become fatal errors with
     this workaround.


### Wicket

#### ConsoleConfiguration.build()

``ConsoleConfiguration.build()`` parameters are modified; you now need to provide a ``IPropertyService``. This method call is generally done in you ``<MyApplication>Application.java``. Just add IPropertyService as a ``@SpringBean`` field, and add it to the method call.
