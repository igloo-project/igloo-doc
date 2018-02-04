======================
Migrating to 1.0 (wip)
======================

This is the first official release of igloo-project, forked from OWSI-Core
project.

No longer supported
-------------------

Hibernate 5.3.0
~~~~~~~~~~~~~~~

Hibernate is mainly a maintenance release, with some important modification:

* Complete list here: http://in.relation.to/2018/01/18/hibernate-orm-530-beta1-release/
* HQL legacy positional parameters removed: https://hibernate.atlassian.net/browse/HHH-12101
* JPA compliance level added: https://github.com/hibernate/hibernate-orm/blob/master/hibernate-core/src/main/java/org/hibernate/jpa/JpaCompliance.java ;
  we choose to use strict compliance enforcement.
* Features for Caching an inheritance: https://hibernate.atlassian.net/browse/HHH-12146
* JPA 2.2 support

Test tooling
~~~~~~~~~~~~

A new **igloo-dependency-test** provides basic dependencies for tests. You can
use this dependency in place of junit, mockito, spring-test, ... dependencies.

**org.iglooproject.jpa.junit.AbstractTestCase** and **org.iglooproject.jpa.EntityManagerExecutionListener**
are moved in a new **igloo-dependency-jpa-test** module. If you want to use
them, add this new dependency with scope test, and fix your imports.

Maven
~~~~~

* unused property ``igloo.gson.version`` is removed

Password encoding
~~~~~~~~~~~~~~~~~

.. note:: **CoreLowerCaseShaPasswordEncoder**, **Md5PasswordEncoder**, **CoreShaPasswordEncoder** removed
   (Spring Security 5 update related)

To know if your application is compatible with new password encoding, please check stored passwords.
If your encoded passwords all start with ``$2a$`` (bcrypt marker), your application may be compatible.

If not you need to write your own password encoder based on code from previous versions. Please take care
of case insensitive check if **CoreLowerCaseShaPasswordEncoder** was used.

This page https://en.wikipedia.org/wiki/Bcrypt, your application configuration, and hashed password patterns
may allow you to identify password encoder behavior and identify needed use-cases.

If you upgrade your application, you should take into consideration to handle
all new passwords with modern hashing (use encoded password prefix to switch encoder behavior).

You should also consider `this paragraph from Spring documentation <https://docs.spring.io/spring-security/site/docs/5.0.1.RELEASE/reference/htmlsingle/#pe-history>`_

Mockito
~~~~~~~

Mockito is upgraded to 2.x version. You way need to rewrite some tests in your
projects.

We recommend to exclude mockito 2.x dependency as a first step and check your
test results without any rewrite, then to update mockito once all your tests are
fixed.
