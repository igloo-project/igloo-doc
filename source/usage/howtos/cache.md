(cache)=

# Cache

In Igloo cache is used :

* By Hibernate as second-level cache
* By Spring at css generation

Each one has an independant `CacheManager`.

As cache provider you can use :

* For Hibernate : EhCache 2.X or JCache (Caffeine)

* For Spring : JCache (Caffeine)

## Update caching backend

* New reference implementation for caching is caffeine
* Second-level cache is configured by `hibernate.cache` property
  (`none`, `ehcache`, `ehcache-singleton`, `jcache-caffeine`)
* Second-level cache configuration file is configured by
  `hibernate.jcache.configurationLocation` (expects a classpath:// url)
* Documentation for caffeine configuration format:
  https://github.com/ben-manes/caffeine/blob/master/jcache/src/main/resources/reference.conf
* `hibernate.ehCache.configurationLocation` is used only for deprecated
  ehcache configuration
* Spring caching now uses spring-boot properties
  https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#appendix.application-properties.cache
* Default configuration and basic-application uses caffeine both for
  spring and hibernate caches
* Rewritten and split monitoring pages in igloo-cache module
* Some cache-related javaconfigs move from basic-application to igloo

(caffeine-migration)=

## Caffeine migration

General instructions for migration :

### Hibernate

* Rewrite <Project>Application : `ConsoleConfiguration.build("console", propertyService);`
  to `ConsoleConfiguration.build("console", propertyService, getResourceSettings());`

* **To keep second-level cache using EhCache** : reconfigure second-level cache :
  * Search `hibernate.ehCache.configurationLocation`
    * If empty, replace with `hibernate.cache=none`
    * If not empty, add `hibernate.cache=ehcache` if you want to keep
      ehcache2
  * Search `hibernate.ehCache.singleton=true`
    * You need `hibernate.cache=ehcache-singleton` instead of ehcache
  * Add `net.sf.ehcache:ehcache` and `org.hibernate:hibernate-ehcache` to
    core dependencies :

    ```xml
    <dependency>
      <groupId>net.sf.ehcache</groupId>
      <artifactId>ehcache</artifactId>
    </dependency>
    <dependency>
      <groupId>org.hibernate</groupId>
      <artifactId>hibernate-ehcache</artifactId>
    </dependency>
    ```

* **To switch second-level cache to Caffeine** :
  * Set `hibernate.cache=jcache-caffeine`
  * Set `hibernate.jcache.configurationLocation=classpath://hibernate/hibernate-jcache-caffeine.conf`
  * Adapt `hibernate-jcache-caffeine.conf` from `ehcache-hibernate.xml` file
    (you can check that correct configuration is loaded in console)
  * Remove `hibernate.ehCache.configurationLocation` property
  * Remove `ehcache-hibernate.xml` file
  * Add `org.hibernate.hibernate-jcache` as core dependency :

    ```xml
    <dependency>
      <groupId>org.hibernate</groupId>
      <artifactId>hibernate-jcache</artifactId>
    </dependency>
    ```
  * Remove `net.sf.ehcache:ehcache` and `org.hibernate:ehcache`

### Spring

* Switch Spring cache to Caffeine :

  * Add `spring.cache.type=caffeine` and
    `spring.cache.caffeine.spec=maximumSize=10, recordStats` in your
    configuration.properties
  * Delete your `<Project>WebappCacheConfig` if you have not difference with
    basic-application defaults. This is now done by igloo spring
    autoconfiguration. Delete this config @import.
  * Delete your `cache-web-context.xml` and `ehcache-cache-web.xml`
    configuration.
    Adapt previously added maximumSize based on this file content.
  * Add `com.github.ben-manes.caffeine:caffeine` and
    `com.github.ben-manes.caffeine:jcache` as core dependency :

    ```xml
    <dependency>
      <groupId>com.github.ben-manes.caffeine</groupId>
      <artifactId>caffeine</artifactId>
    </dependency>
    <dependency>
      <groupId>com.github.ben-manes.caffeine</groupId>
      <artifactId>jcache</artifactId>
    </dependency>
    ```

* Add igloo-cache to webapp dependencies :

  ```xml
  <dependency>
    <groupId>org.iglooproject.components</groupId>
    <artifactId>igloo-cache</artifactId>
    <version>${igloo.version}</version>
  </dependency>
  ```
