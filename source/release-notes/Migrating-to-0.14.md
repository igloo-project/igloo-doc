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


### Hibernate Search & Lucene

We have upgraded Hibernate Search to the 5.7.0.Final which is not yet compatible
with Lucene 6 but require at least Lucene 5.5.X so we upgraded Lucene to the
5.5.4 version.

The utilization of `setBoost(float)` and `getBoost()` directly to a Query is now
deprecated. Instead we use the type `BoostQuery` to apply boost.

Configuration
-------------

 * The `ExplicitJpaConfigurationProvider` class no longer exists, all the configuration is now exclusively provided
 by the `DefaultJpaConfigurationProvider` class.


Behavior checking
-----------------

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
