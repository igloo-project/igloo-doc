(external-link-checker)=
# External Link Checker

## About

Igloo has a service called the external link checker. It's used to check that external links stays valid.

It's currently used in production to validate several 100k links.

It is based on the HTTPClient library. It first tries a HEAD request to limit the bandwidth usage, it tries a GET request if the HEAD request fails.

If a link is unreachable, it is marked as `OFFLINE`. After several checks being offline (to avoid transient errors), the link is marked as `DEAD_LINK`.

## Model

The link must be wrapped in an `ExternalLinkWrapper`:
```java
@OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.ALL }, orphanRemoval = true)
private ExternalLinkWrapper externalLinkWrapper;
```

The status of the link is available in the `ExternalLinkWrapper`. A link is considered invalid if it's in the `DEAD_LINK` status.

## Usage

### Maven

Starting with Igloo 0.11, ExternalLinkChecker has its own Maven module:
```xml
<dependency>
    <groupId>org.iglooproject.components</groupId>
    <artifactId>igloo-component-jpa-externallinkchecker</artifactId>
    <version>${project.version}</version>
</dependency>
```
### Configuration

The configuration is as follows:
```
externalLinkChecker.timeout=30000
externalLinkChecker.userAgent=Your user agent
externalLinkChecker.batchSize=400
externalLinkChecker.retryAttemptsNumber=4
externalLinkChecker.maxRedirects=5
externalLinkChecker.cronExpression=0 0/15 3-6,18-23 * * ?
```

The cron expression must be used to configure a scheduled task which launches `externalLinkCheckerService.checkBatch()`.

You can ignore links by adding regexps using the `externalLinkCheckerService.addIgnorePattern(pattern)` method.

In `YourAppCoreCommonConfig`, you have to:
* add `JpaExternalLinkCheckerBusinessPackage` to the `basePackageClasses` of `@ComponentScan`

In `YourAppCoreCommonJpaConfig`, you have to:
* add `JpaExternalLinkCheckerBusinessPackage` to the package scanned for entities in `applicationJpaPackageScanProvider()`
* declare an Hibernate interceptor:
```
        @Bean
        public Interceptor hibernateInterceptor() {
                return new ChainedInterceptor()
                                .add(new ExternalLinkWrapperInterceptor());
        }
```
