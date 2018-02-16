======================
Migrating to 1.0 (wip)
======================

This is the first official release of igloo-project, forked from OWSI-Core
project.

.. contents:: :local:


Major modifications
-------------------

.. toctree::
  :maxdepth: 1

  1.0/configuration.rst
  1.0/hibernate.rst


Updated
-------

Infinispan
~~~~~~~~~~

With jgroups 4.0, Infinispan don't use any longer oob and internal threads.
You have to remove all ``internal_thread_pool.*``, ``oob_thread_pool.*`` and
``thread_pool.queue_enabled`` settings in your jgroups configuration
(``*jgroup*.xml`` files).

See http://planet.jboss.org/post/removing_thread_pools_in_jgroups_4_0

All references to ``org.jgroups.Address`` must be replaced with
``org.iglooproject.infinispan.model.AddressWrapper`` (as Address is no longer
``Serializable``, AddressWrapper handles Serialization).


Mockito
~~~~~~~

Mockito is upgraded to 2.x version. You way need to rewrite some tests in your
projects.

We recommend to exclude mockito 2.x dependency as a first step and check your
test results without any rewrite, then to update mockito once all your tests are
fixed.


No longer supported
-------------------

JDK 7
~~~~~

JDK 7 support is removed as planned.



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

Property ``security.passwordSalt`` and method ``DefaultJpaSecurityConfig.getPasswordSalt()`` are removed.


YUI Compressor
~~~~~~~~~~~~~~

YUI Compressor (maven plugin, minification at build time) is removed as it
was no longer used to provide minification (handled internally at runtime by
wicket).

I you use YUI Compressor, you need to include your maven plugin configuration
inside your project.


maven-release-plugin
~~~~~~~~~~~~~~~~~~~~

Removed. Use jgitflow or reconfigure release plugin in your project.


tomcat-jdbc
~~~~~~~~~~~

We use HikariCP as database pool provider. tomcat-jdbc is no longer used.
Switch to HikariCP.

As tomcat-jdbc is a provided dependency (included in tomcat), this may not
affect your web-application. It may affect your tests or main scripts: if this
is the case, you need to ensure that tomcat-jdbc dependency connfiguration
is correct.


Joda-Time
~~~~~~~~~

Joda-Time is removed from dependency; you can continue to use it by re-adding
this dependency to your project.


New features
------------

Test tooling
~~~~~~~~~~~~

A new **igloo-dependency-test** provides basic dependencies for tests. You can
use this dependency in place of junit, mockito, spring-test, ... dependencies.

**org.iglooproject.jpa.junit.AbstractTestCase** and **org.iglooproject.jpa.EntityManagerExecutionListener**
are moved in a new **igloo-dependency-jpa-test** module. If you want to use
them, add this new dependency with scope test, and fix your imports.
