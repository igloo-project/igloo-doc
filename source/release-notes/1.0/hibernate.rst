
hibernate.implicit_naming_strategy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``org.iglooproject.jpa.hibernate.model.naming.ImplicitNamingStrategyLegacyJpaComponentPathImpl``
is removed and replaced with ``ImplicitNamingStrategyJpaComponentPathImpl``.

To check if this change is problematic with your database model, use ``*SqlUpdateScriptMain``
to check and compare new database model with your previous version.


Hibernate 5.2.13 (upstream)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Changes in the @TableGenerator and @SequenceGenerator name scope
----------------------------------------------------------------

cf http://in.relation.to/2018/02/07/hibernate-orm-5213-final-release/

  In order to be compliant with the JPA specifications, the names of identity generators
  need now be considered global, and no longer scoped to the entity in which they are declared.
  This means existing applications might now have a naming conflict which needs to be addressed
  to upgrade. Configuring two generators, even with different types but with the same name will
  now cause a java.lang.IllegalArgumentException to be thrown at boot time.

TODO lazy-loading on identifier access


Hibernate 5.3.0 (upstream) (?)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Hibernate is mainly a maintenance release, with some important modification:

* Complete list here: http://in.relation.to/2018/01/18/hibernate-orm-530-beta1-release/
* HQL legacy positional parameters removed: https://hibernate.atlassian.net/browse/HHH-12101
* JPA compliance level added: https://github.com/hibernate/hibernate-orm/blob/master/hibernate-core/src/main/java/org/hibernate/jpa/JpaCompliance.java ;
  we choose to use strict compliance enforcement.
* Features for Caching an inheritance: https://hibernate.atlassian.net/browse/HHH-12146
* JPA 2.2 support
