# Migrating to 0.12

This guide aims at helping OWSI-Core users migrate an application based on OWSI-Core 0.11 to OWSI-Core 0.12.

**In order to migrate from an older version of OWSI-Core, please refer to [Migrating to 0.11](Migrating-to-0.11.html) first.**

Tools
--------------

### Animal sniffer

JDK level validation using [Animal sniffer](http://www.mojohaus.org/animal-sniffer/animal-sniffer-maven-plugin/) is now enabled by default. This will probably force you to use JDK7 to build your project.

If the default JDK version (1.7) does not suit you, you should:

 * change the value of the `jdk.version` property (as usual)
 * and change the value of the `jdk.signature.artifactId` property to match one of the artifacts found here: http://search.maven.org/#search|ga|1|g%3A%22org.codehaus.mojo.signature%22

If this is somehow impossible and you want to disable these checks completely, you should disable the Animal Sniffer execution with id "check-java-version".

### Bindings & code processors
There has been [some changes](https://github.com/openwide-java/owsi-core-parent/commit/0fadc462b451d7eed883f0de0bcdf6bb47308eb1) regarding code processors. You will have to replace the goals of your `*.launch` files: instead of `generate-sources`, use `generate-sources generate-test-sources`.

External changes (libraries)
----------------------------

### Spring & Spring Security

 * change the `-4.0.xsd` schema to `-4.1.xsd` (Spring Security namespaces)

### Wicket

 * It seems like Wicket changed the implementation of URL mapping. There isn't many side effects, but one of them is the following: if you have mounted your two-parameter page twice, once with a trailing "/${param1}/" and once with a trailing "/${param1}/#{param2}", then Wicket will fail miserably and perform infinite redirections.
   * That's why it is now recommended, **for every page whose URL ends with a path parameter**, to mount the page with **no trailing slash**. Then the case mentioned above will work as a charm, and this will have the added benefit of allowing clients to use both versions of the URL: with or without a trailing slash.
   * Please note that if you skip the trailing slash for a page whose URL **does not** end with a path parameter, then Wicket will not allow accessing this page with a trailing slash (which is probably a bug). So **do not do this for pages whose URL does not end with a path parameter**.

Internal changes
------------------

### Core

 * Some classes' attributes have been renamed:
  * `GenericEntityReference.getEntityId()` became `GenericEntityReference.getId()`
  * `GenericEntityReference.getEntityClass()` became `GenericEntityReference.getType()`
  * `HistoryValue.getEntityReference()` became `HistoryValue.getReference()`
  * This could cause column name changes in your schema
  * See https://github.com/openwide-java/owsi-core-parent/commit/33173617a905bdb110ee840acdad46fd20127b7f for details
 * There's been some changes around notification descriptors in order to allow for applications to define user-specific context (`fr.openwide.core.spring.notification.model.INotificationContentDescriptor.withContext(INotificationRecipient)`). Thus:
  * You're encouraged to use `NotificationContentDescriptors.explicit("defaultSubject", "defaultTextBody", "defaultHtmlBody")` as your default descriptor in your `EmptyNotificationContentDescriptorFactoryImpl`.
  * Your notification content descriptor factories should not have a generic return type anymore, they should simply return `INotificationContentDescriptor`. Check out `NotificationDemoPage` and `ConsoleNotificationDemoIndexPage` from the basic application and use similar code in your own `NotificationDemoPage` and `ConsoleNotificationDemoIndexPage` in order to not depend on `IWicketNotificationDescriptor` anymore.
 * JPAModelGen support is dropped in IGenericEntityDao/GenericEntityDaoImpl (*ByField) ; queries should be written with QueryDSL API, or compatibility layer may be extracted from GenericEntityDaoImpl 0.11.

## Security

The unauthorized access mechanisms have been revamped, for more consistency:

 * `AccessDeniedPage` is now accessed whenever a Wicket authorization error occurs.
 * It is now clearer that `AccessDeniedPage` is **not** used when an anonymous user tries to access a protected resource.
 * OWSI-Core's own redirection mechanism has been deprecated in favor of more standard ones (Wicket's and Spring Security's). On this particular subject, see [UI Redirecting](../howtos/UI-Redirecting.html).

In order for your application to continue to work properly:

 * You will need to add both `REQUEST` and `FORWARD` dispatchers to your Wicket application's filter mapping, so that Spring Security may forward requests when an access is denied.

   This:
   ```
	<filter-mapping>
		<filter-name>MyApplication</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
   ```

   will have to become this:

   ```
	<filter-mapping>
		<filter-name>MyApplication</filter-name>
		<url-pattern>/*</url-pattern>
		<dispatcher>REQUEST</dispatcher>
		<dispatcher>FORWARD</dispatcher>
	</filter-mapping>
   ```
 * If you overrode the default exception mapper, and you did not extend `CoreDefaultExceptionMapper` you may want to add this at the very top of your `map` method, outside of any `try` block:

   ```
		if (e instanceof AuthorizationException) {
			throw new AccessDeniedException("Access denied by Wicket's security layer", e);
		}
   ```

   This will translate a wicket exception into something Spring Security can understand.

 * If you overrode the default exception mapper, and you **did** extent `CoreDefaultExceptionMapper`, beware that your call to `super.map(e)` may now throw an `org.springframework.security.access.AccessDeniedException` which should not be caught. Ensure this call is made outside of a `try` block.

### Webapp

 * Some more logs have been added to `GenericEntityModel` and `AbstractThreadSafeLoadableDetachableModel`. See https://github.com/openwide-java/owsi-core-parent/wiki/UI-Models#debugging for more information.
 * `DynamicImage`s, obtained through `IImageResourceLinkGenerator`s, now have their anticache parameter disabled by default. This may increase performance in Ajax refreshes where the same image appears multiple times. But it also means you will have to add a sensible anticache parameter to your image resources, such as `?t=<the last time your image was changed>`. You may do this when building your link descriptor, for instance with `fr.openwide.core.wicket.more.link.descriptor.builder.state.parameter.chosen.common.IOneChosenParameterState.renderInUrl(String, AbstractBinding<? super TChosenParam1, ?>)`.
 * `IFormModelValidator` now extends `IDetachable`. You should implement `detach` as necessary.
 * `ModelValidatingForm.addFormModelValidator(IFormModelValidator, IFormModelValidator ...)` has been renamed to simply `add`.
 * `ModelValidatingForm.addFormModelValidator(Collection)` has been removed.
 * `GenericEntityCollectionView` has been deprecated in favor of the more generic `CollectionView`. See `GenericEntityCollectionView`'s javadoc for information on migrating existing code.
 * `SerializedItemCollectionView` has been deprecated in favor of the more generic `CollectionView`. See `SerializedItemCollectionView`'s javadoc for information on migrating existing code.
 * `GenericEntity` collection models (`GenericEntityArrayListModel`, `GenericEntityTreeSetModel`, ...) have been deprecated in favor of the more generic `CollectionCopyModel`. See each older model's javadoc for information on migrating existing code.
 * `IWicketContextExecutor` has been deprecated in favor of the more flexible `IWicketContextProvider`. Here are the main consequences to existing applications:
   * An object of type `IWicketContextProvider` is now available in the Spring context. You may `@Autowire` it in your own beans, or redefine it by overriding `fr.openwide.core.wicket.more.config.spring.AbstractWebappConfig.wicketContextProvider(WebApplication)` in your own webapp configuration.
   * The signature of `fr.openwide.core.wicket.more.config.spring.AbstractWebappConfig.wicketContextExecutor(WebApplication)` has changed and is now `fr.openwide.core.wicket.more.config.spring.AbstractWebappConfig.wicketContextExecutor(IWicketContextProvider)`. It cannot be overridden anymore. Please override `fr.openwide.core.wicket.more.config.spring.AbstractWebappConfig.wicketContextProvider(WebApplication)` instead.
   * Classes extending `AbstractWicketRendererServiceImpl`, `AbstractNotificationContentDescriptorFactory`, `AbstractNotificationUrlBuilderServiceImpl`, `AbstractNotificationPanelRendererServiceImpl` must now provide a `IWicketContextProvider` to their super constructor instead of a `IWicketContextExecutor`.
   * Classes extending `AbstractBackgroundWicketThreadContextBuilder` should instead rely on a `IWicketContextProvider`.
   * Classes relying on a `IWicketContextExecutor` should instead rely on a`IWicketContextProvider`. Here are a few examples of code refactoring:

		```
		String result = wicketExecutor.runWithContext(
			new Callable<String>() {
				public String call() throws Exception {
					return doSomethingThatRequiresAWicketContext();
				}
			},
			locale
		);
		```

		becomes

		```
		String result;
		try (ITearDownHandle handle = wicketContextProvider.context(locale).open()) {
			result = doSomethingThatRequiresAWicketContext();
		}
		```

		 And if you really must use a `Callable`:

		```
		String result = wicketExecutor.runWithContext(someCallable, locale);
		```

		becomes

		```
		String result = wicketContextProvider.context(locale).run(someCallable);
		```
 * `IOneParameterConditionFactory`, `IOneParameterModelFactory`, `AbstractOneParameterConditionFactory` and `AbstractOneParameterModelFactory` have been deprecated and replaced by `IDetachableFactory` and `AbstractDetachableFactory`. See their respective Javadoc for more information on migrating existing code.
 * `LinkDescriptorBuilder`'s syntax changed slightly.

  Previously, the entry point to building a link descriptor was `LinkDescriptorBuilder#LinkDescriptorBuilder()`, which was followed by a call to determine the type of the target, then various stuff around parameters, and finally a call to the `build()` method.

  Now, the entry point is `LinkDescriptorBuilder#start()`, followed by various stuff around parameters, and finally a call to one of the build methods: `page`, `resource`, or `imageResource`.

  The old syntax is still valid, but has been deprecated and will be removed in the future.

  So something that we previously wrote this way:

  ```
      public static final IOneParameterLinkDescriptorMapper<IPageLinkDescriptor, User> MAPPER =
              new LinkDescriptorBuilder().page(MyPage.class)
                      .model(User.class).map("id").permission(READ)
                      .build();
  ```

  ... will now have to be written this way:

  ```
      public static final IOneParameterLinkDescriptorMapper<IPageLinkDescriptor, User> MAPPER =
              LinkDescriptorBuilder.start()
                      .model(User.class).map("id").permission(READ)
                      .page(MyPage.class);
  ```

  For existing projects, [this perl script](https://gist.github.com/fenrhil/6c84547f5374dac59aa93caa4ef7c670) may help. Execute it this way from your project root:

  ```
  find . -name '*.java' | xargs -n 1 -I{} bash -c 'TMP="$(mktemp)" ; perl -- ../linkdescriptorbuilder_migrate.pl "{}" > $TMP ; diff -Zq "$TMP" {} >/dev/null || mv "$TMP" {}'
  ```

  It will try its best to convert most uses of `new LinkDescriptorBuilder` to `LinkDescriptorBuilder.start()`, converting early target definitions to late target definitions in the process. It should leave compilation errors wherever the conversion was not easy enough, so you can detect the places where you should edit code manually.
 * **IPageLinkGenerator** implementations enforce permission checking in `getValidPageClass()`, hence in `fullUrl()` ; if you used `fullUrl()` to bypass permission checking (for example for email notification sent to another user than the one connected), replace `fullUrl()` by `bypassPermissions().fullUrl()`. NOTE: this backward compatibility is available only on former implementations, `CorePageInstanceLinkGenerator` and `CorePageLinkDescriptorImpl`; if you use newer implementions, you already should conform to the new behavior.
 * **Ajax confirm link builder**: Ajax confirm link builder is now « form submit » aware ; current AjaxSubmitLink may be rewritten with `AjaxConfirmLink.build().[...].submit(form)`. AjaxSubmitLink still available.
 * **Confirm link builder**: introduced `ConfirmLink.build()` builder. Unified syntax with ajax confirm link and ajax confirm submit. Confirm submit not supported (it was already a missing functionnality).
 * **Confirm link**: introduced custom styles for yes / no buttons. Default values constructors were added to enable back-compatibility.
 * **Condition and behavior**: EnclosureBehavior and PlaceholderBehavior are
deprecated and replaced by behavior generation's methods on `Condition`
object. This pattern allows to use more easily and consistently any `Condition`
to control component's visibility or enabled property. More documentation on
this pattern and the way to rewrite your code [UI Placeholder and Enclosure](../howtos/UI-Placeholder-and-Enclosure.html)
