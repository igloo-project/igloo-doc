# Securing accesses

This page explains how to ensure that parts of your application (pages, buttons, resources, but also Spring services) are only accessible to entitled users.

## Principles

Here are some basic principles. These are not really formal security science, but are just intended to provide readers with enough understanding of Igloo's security to get started.

### Security model

Here are the concepts used in Igloo's security model :

 * A *user* is a user of your application.
 * A *user group* is a business-level category of users.
 * An *object*, or *resource*, is the thing whose access is to be secured. It's generally a business domain object (such as a "customer", or a "deal", and so on).
 * A *role* is a functional-level category of users. One or many roles may be attributed to a user or to a user group.
 * A *global permission* is an approval of a mode of access to a class of objects, an authorization which is not tied to a an object in particular (such as "write to customer contact details"). One or many global permissions may be attributed to a role.
 * An *object permission* is an approval of a mode of access to an object in particular, an authorization which **is** tied to a an object in particular (such as "write to the contact details of customer Initech, Inc"). An object permission is never attributed, it is computed in a fully qualified context: given a user, an object and an object permission, the security system will compute the answer to the question "does the user have this permission on this object?".

You may notice that, depending on your point of view, some concepts seem to have the same purpose: either role and global permission or role and user group. The developers are aware of this issue and it will be addressed in a future version of Igloo.

### Architecture

Igloo's security layer is powered by [Spring Security](http://projects.spring.io/spring-security/), and most concepts detailed here come directly from Spring Security.

Here are the main components of a secured application based on Igloo:

 * The `ISecurityService` is an API, the main entry point for security-related queries ("does this user have this permission on this object") and operations (user authentication, authentication invalidation, ...).
 * The `PermissionEvaluator` is a SPI, the way for the developer to programmatically define code that will determine whether a user has a given permission on a given object. This code is not just a mapping, as it may use business object's properties in order to answer queries: for instance "is the given user this customer's account manager?". **Think of permissions evaluators as a way to extract business information for security purposes**. The permission evaluator is generally implemented through a subclass of `AbstractCorePermissionEvaluator` which delegates its calls to various `IGenericPermissionEvaluator`, one for each type of object.
 * The `UserDetailsService` is a SPI, the way for the developer to programmatically define code that will determine whether a user has a given role or global permission. It's generally a subclass of `CoreJpaUserDetailsServiceImpl`. **Think of the user details service as a way to extract user role and permission attributions.** This code consists, most of the time, in:
  * extracting role and global permission attributions from the database
  * expanding the results to extensive lists with the help of a role hierarchy and a permission hierarchy
  * and optionally inferring hard-coded global permissions based on on attributed roles

## Defining your own permissions

### Defining role constants

Create a class named `<YourApplication>AuthorityConstants`, extending `CoreAuthorityConstants`, and put it in `<Your main package>.core.security.model`.
In this class, add one string constant for each role, making sure that each constant has a unique value:

```java
public final class MyApplicationAuthorityConstants extends CoreAuthorityConstants {

	public static final String ROLE_INTRANET_USER = "ROLE_INTRANET_USER";
	public static final String ROLE_EXTRANET_USER = "ROLE_EXTRANET_USER";

}
```

### Defining permission constants

Create a class named `<YourApplication>PermissionConstants`, extending `CorePermissionConstants`, and put it in `<Your main package>.core.security.model`.
In this class, add one string constant for each global permission or object permission, making sure that each constant has a unique value:

```java
public final class MyApplicationPermissionConstants extends CorePermissionConstants {
	public static final String CUSTOMER_WRITE_CONTACT_DETAILS = "CUSTOMER_WRITE_CONTACT_DETAILS";
}
```

Then, create another class named `<YourApplication>Permission`, extending NamedPermission, and with the following implementation:

```java
public final class MyApplicationPermission extends NamedPermission {

	private static final long serialVersionUID = 8541973919257428300L;

	public static final Collection<MyApplicationPermission> ALL;
	static {
		ImmutableSet.Builder<SIPermission> builder = ImmutableSet.builder();
		Field[] fields = MyApplicationPermissionConstants.class.getFields();
		for (Field field : fields) {
			try {
				Object fieldValue = field.get(null);
				if (fieldValue instanceof String) {
					builder.add(new MyApplicationPermission((String)fieldValue));
				}
			} catch (IllegalArgumentException|IllegalAccessException ignored) { // NOSONAR
			}
		}
		ALL = builder.build();
	}

	private MyApplicationPermission(String name) {
		super(name);
	}

}
```

And finally, override permissionFactory in your security configuration class, which extends `AbstractJpaSecurityConfig`. Here is an implementation example:

```java
@Configuration
public class MyApplicationCoreSecurityConfig extends AbstractJpaSecuritySecuredConfig {

	/** ... other stuff ... */

	@Override
	public PermissionFactory permissionFactory() {
		return new NamedPermissionFactory(MyApplicationPermission.ALL);
	}

	/** ... other stuff ... */
}
```

### Defining role and permission hierarchies

This is done by overriding `roleHierarchyAsString` and `permissionHierarchyAsString` in your security configuration class, which extends `AbstractJpaSecurityConfig`. Here is an implementation example:

```java
import static my.application.core.security.model.MyApplicationAuthorityConstants.*;
import static my.application.core.security.model.MyApplicationPermissionConstants.*;

@Configuration
public class MyApplicationCoreSecurityConfig extends AbstractJpaSecuritySecuredConfig {

	/** ... other stuff ... */

	@Override
	public String roleHierarchyAsString() {
		return defaultRoleHierarchyAsString() + hierarchyAsStringFromMap(
				ImmutableMultimap.<String, String>builder()
				.putAll(
						ROLE_ADMIN,
						ROLE_INTRANET_USER,
						ROLE_TECHNICAL_ADMIN
				)
				.putAll(
						ROLE_INTRANET_USER,
						ROLE_AUTHENTICATED
				)
				.putAll(
						ROLE_EXTRANET_USER,
						ROLE_AUTHENTICATED
				)
				.putAll(
						ROLE_SYSTEM,
						ROLE_ADMIN,
						ROLE_MAIN_USER,
						ROLE_EXTRANET_USER
				)
				.build()
		);
	}

	@Override
	public String permissionHierarchyAsString() {
		return defaultPermissionHierarchyAsString() + hierarchyAsStringFromMap(
				ImmutableMultimap.<String, String>builder()
				.put(CUSTOMER_WRITE, CUSTOMER_READ)
				.build()
		);
	}

	/** ... other stuff ... */
}
```

### Defining permission evaluators

Then, go to your permission evaluator. You may find a reference to this class in your configuration class that extends `AbstractJpaSecurityConfig`, in the `permissionEvaluator` method.

In this permission evaluator, you will have to dispatch security queries to various permission evaluators, one for each object type. This will look like this:

```java
public class MyApplicationPermissionEvaluator extends AbstractCorePermissionEvaluator<User> {

	@Autowired
	private ICustomerPermissionEvaluator customerFormationPermissionEvaluator;

	@Autowired
	private IDealPermissionEvaluator dealPermissionEvaluator;

	@Autowired
	private IInvoicePermissionEvaluator invoicePermissionEvaluator;

	public MyApplicationPermissionEvaluator() {
		// nothing to do
	}

	@Override
	protected boolean hasPermission(User user, Object targetDomainObject, Permission permission) {
		if (targetDomainObject != null) {
			targetDomainObject = HibernateUtils.unwrap(targetDomainObject); // NOSONAR
		}

		if (user != null) {
			user = HibernateUtils.unwrap(user); // NOSONAR
		}

		if (targetDomainObject instanceof Customer) {
			return customerPermissionEvaluator.hasPermission(user, (Customer) targetDomainObject, permission);
		} else if (targetDomainObject instanceof Deal) {
			return dealPermissionEvaluator.hasPermission(user, (Deal) targetDomainObject, permission);
		} else if (targetDomainObject instanceof Invoice) {
			return invoicePermissionEvaluator.hasPermission(user, (Invoice) targetDomainObject, permission);
		}


		return false;
	}
}
```

For each type-bound permission evaluator, you will define an interface (which extends `IGenericPermissionEvaluator`) and an implementation. Here is an example of implementation (you are, of course, totally free of which permissions you will or will not handle):

```java
@Service
public class CustomerPermissionEvaluatorImpl extends AbstractMyApplicationGenericPermissionEvaluator<Customer>
		implements ICustomerPermissionEvaluator {

	@Autowired
	private IUserService userService;

	@Autowired
	private IParticipationPermissionEvaluator participationPermissionEvaluator;

	@Override
	public boolean hasPermission(User user, Customer customer, Permission permission) {
		if (is(permission, READ)) {
			return hasPermission(user, CUSTOMER_READ);
		} else if (is(permission, CREATE)) {
			return hasPermission(user, CUSTOMER_CREATE);
		} else if (is(permission, WRITE)) {
			return user.equals(customer.getAccountManager());
		}
		return false;
	}
}
```

## Restricting accesses

### Service layer

#### General configuration

In order to enable security checks upon method calls, you will need to make sure that your security configuration class does not extend `AbstractJpaSecuritySecuredConfig` directly, but its subclass, `AbstractJpaSecuritySecuredConfig`.

#### Service access

You will need to add annotations on your services' methods. For instance:
s
```java
public interface ICustomerService extends IGenericEntityService<Long, Customer> {

	@Override
	@PreAuthorize(value = MyAppSecurityExpressionConstants.CREATE)
	void create(@PermissionObject Customer entity) throws ServiceException, SecurityServiceException;

}
```

`@PreAuthorize` will perform a security check before executing the method. Other, more exotic annotations exist in package `org.springframework.security.access.prepost`.

It's better to define your security expressions in a separate constants class, such as `MyAppSecurityExpressionConstants` in this example. This class will look something like that:

```java
import static org.iglooproject.commons.util.security.PermissionObject.DEFAULT_PERMISSION_OBJECT_NAME;

public final class SISecurityExpressionConstants {

	public static final String READ = "hasPermission(#" + DEFAULT_PERMISSION_OBJECT_NAME + ", '" + SIPermissionConstants.READ + "')";
	public static final String CREATE = "hasPermission(#" + DEFAULT_PERMISSION_OBJECT_NAME + ", '" + SIPermissionConstants.CREATE + "')";
	public static final String WRITE = "hasPermission(#" + DEFAULT_PERMISSION_OBJECT_NAME + ", '" + SIPermissionConstants.WRITE + "')";

}
```

Note that annotating the method's main parameter with `@PermissionObject` and using `PermissionObject.DEFAULT_PERMISSION_OBJECT_NAME` in your security expressions will ensure that changing the name of this parameter will not break your security expressions.

### UI layer

#### General configuration

The general web application security configuration is generally located in a class named `<YourApp>WebappSecurityConfig`.

This class generally refers to an XML file (`security-web-context.xml`) whose content defines:

 * security-related beans
 * required roles for each page (or set of pages, by using regular expressions)
 * login workflow (login page, login failure page, login success page)
 * denied access behavior
 * session restrictions (such as a maximum number of simultaneous sessions)

The official documentation about the format of this file may be found there: http://docs.spring.io/spring-security/site/docs/4.0.x/reference/html/ns-config.html

#### Page and resource access

##### Simple, coarse-grained configuration

You may define, for a given page or resource, which roles or global permissions are required in order to access it.

This is simply done by adding the `@AuthorizeInstantiation` (for roles) or `@AuthorizeInstantiationIfPermission` (for global permissions) on the page's class. For resources, you must use `@AuthorizeResource` instead, and you may not rely on permissions (only roles).

Be aware that, while more annotations are available (`@AuthorizeAction` and `@AuthorizeActionIfPermission` in particular), their use is discouraged because they add restrictions which cannot be checked until the very last moment. This prevents in particular from disabling links to inaccessible pages (because, when rendering the link, the page is not yet instantiated and thus we can't check action permissions on this page).

##### Advanced, fine-grained configuration

Most of the time, you will use link descriptors (see [UI-Links](UI-Links.html)) in order to provide access to pages or resources.

Link descriptors allow to define arbitrary access restrictions (based on model objects, or on anything you want), and this includes in particular authorization restrictions.

For instance, this allows to make a link accessible only when the users has the "READ" permission on the parameter:

```java
public static final IOneParameterLinkDescriptorMapper<IPageLinkDescriptor, MyObject> MAPPER =
		new LinkDescriptorBuilder()
		.page(MyObjectPage.class)
		.model(MyObject.class)
				.permission(CorePermissionConstants.READ)
				.map(CommonParameters.ID).mandatory()
		.build();
```

You may also enforce checks on global permissions, by calling the `.permission` method before defining any parameter:

```java
public static final IOneParameterLinkDescriptorMapper<IPageLinkDescriptor, MyObject> MAPPER =
		new LinkDescriptorBuilder()
		.page(MyObjectPage.class)
		.permission(MyApplicationPermissionConstants.ACCESS_MY_OBJECT_PAGE)
		.model(MyObject.class)
				.map(CommonParameters.ID).mandatory()
		.build();
```

Please note that all of this also applies to resource link descriptors.

With this configuration, checks will be performed upon link rendering and upon page/resource instantiation:

 * when links are rendered, they will be automatically disabled or hidden if the user misses some roles or permissions
 * when the a page or resource is instantiated, it will use the link descriptor to extract parameters, which will trigger an exception and abort the page instantiation if the user misses some roles or permissions.

#### Buttons/links access

When using links created from a link descriptor, if this link descriptor has been properly configured as explained above, the link will automatically be disabled whenever the user hasn't the required permissions.

For other links (external links for instance) or for buttons, ajax links, and so on, you may hide or disable these components using enclosure behaviors:

```java
final IModel<T> model = /*...*/;
add(
		new AjaxLink("link", model) {
			/* ... */
		}
				.add(
						new EnclosureBehavior().condition(
								Condition.permission(model, MyApplicationPermissionConstants.MY_PERMISSION)
						)
				)
);
```

This will trigger server-side hiding, which will prevent users to trigger the server-side code even if they can guess and call the URL for each button: Wicket refuses to execute code on components that were hidden on the server side.

#### Popups/modals access

For modals which require initialization before showing them, you should add an enclosure behavior on the opening link:

```java
MyModal editPopup = new MyModal("popup");
add(editPopup);

// The following code is potentially executed multiple times, for different models
final IModel<T> itemModel = /*...*/;
add(
		new BlankLink("edit")
				.add(
					new AjaxModalOpenBehavior(editPopup, MouseEvent.CLICK) {
						private static final long serialVersionUID = 1L;
						@Override
						protected void onShow(AjaxRequestTarget target) {
							editPopup.init(itemModel.getObject());
						}
					}
				)
				.add(
						new EnclosureBehavior().condition(
								Condition.permission(model, MyApplicationPermissionConstants.MY_PERMISSION)
						)
				)
);
```

This ensures that the modal will be initially visible, but unusable (because it's not initialized), and that it will be "openable" if and only if at least one button is visible.

For modals whose content is fully determined by their main model, and which do not require initialization upon showing them, it is recommended to apply an enclosure behavior on the modal itself:

```java
IModel<T> model = /*...*/;
MyModal editPopup = new MyModal("popup", model);
add(
		editPopup
				.add(
						new EnclosureBehavior().condition(
								Condition.permission(model, SIPermissionConstants.WRITE)
						)
				)
		new BlankLink("edit")
				.add(new AjaxModalOpenBehavior(editPopup, MouseEvent.CLICK))
);
```

This ensures that when the use has no access to the modal, even if the client tries to execute a manually-crafted ajax call to open the modal, the modal will be hidden on the server-side and wicket will thus trigger an error.
