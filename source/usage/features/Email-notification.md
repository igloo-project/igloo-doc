(email)=

# E-mail notifications

```{contents}
:local: true
```

## Features

Email notification system provides the following feature:

- Builder design pattern for sending notifications (with method chaining,
  #from(), #sender(), #to(), #subject(), #textBody(), ...).
  See `NotificationBuilder` class and `INotificationBuilderState*` interfaces.
- Freemarker templates for text notifications (deprecated).
- Wicket-based templates for HTML notifications.
- CSS style inlining to ensure a large client compatibility for reading
  generated HTML messages.
- Support Wicket generation both inside and outside request's context
  (Wicket-based HTML emails can be generated during request, scheduled
  jobs or tasks).
- Notification grouping or splitting based on recipient-based preférences
  (split one #send() call to one message for french recipients and
  another for english recipients).
- Special behaviors for test environments (email filtering).

## NotificationBuilder

### Send a simple notification

```java
INotificationBuilderBaseState builder = NotificationBuilder.create().init(applicationContext);
builder.from("from@example.com").to("to@example.com")
  .subject("subject").textBody("content").send();
```

### Send a wicket-based HTML notification

To send a wicket-based HTML notification, you'll need to provide a
*NotificationContentDescriptorFactoryImpl*. basic-application provides an
example named `BasicApplicationNotificationContentDescriptorFactoryImpl`.

This object provides for each of your notification a
`INotificationContentDescriptor` with the methods to render subject, text body
and html body. Inhering `AbstractWicketNotificationDescriptor` allows to
delegate html body generation to a wicket component.


### Common behavior

* A method in `NotitificationServiceImpl`
* Build a `NotificationBuilder` instance
* Setup recipients (to, cc), reply-to, ...
* `INotificationRecipient` can be used for user to email / locale / profile information
* Wicket context :
  * If mail is sent outside of wicket context (task, scheduled job), wicket
    context is determined from `IWicketContextProvider` bean. `wicket.backgroundThreadContextBuilder.*`
    properties must be setup
  * Else current wicket context is reused
  * Wicket context lookup is performed in `AbstractOfflinePanelRendererServiceImpl`
    (try-with-resources with `ITearDownHandle`)
* Rendering is done with a `runAsSystem` wrapper (as the sender context is rarely useful
  to manager component visibility) (done in `AbstractWicketRendererServiceImpl`)
* Rendering locale (in wicket context) is done consistently with recipient's declared
  locale (see `INotificationRecipient#getLocale` method). If your application allow
  multi-locale settings, ensure this is the expected behavior
* If multiple locales are needed to honor recipient's locales, there is one generation
  and one sending by targetted locale


### Warnings

* A System security context is used for email rendering. Do not rely on dynamic
  component visibility if you use default sending options
* Pay special attention to wicket context if you use multiple Wicket applications.
  Wicket application affects Page to URL translation (page may have different URL,
  or no bookmarkable URL in some application) and absolute URL translation
  (hostname can be customized for each application)
* If you use multiple wicket applications, pay attention that email sending is done
  with the expected application (example: extranet/intranet splitted application may
  trigger send from intranet to extranet users)


### Offline renderding and URL

For offline or overriden rendering, page to URL translation is done with hostname, scheme and port
extracted from `wicket.<APPLICATION_NAME>.backgroundThreadContextBuilder.url.(servletPath|scheme|port|serverName)`.

Default values are extracted from `wicket.backgroundThreadContextBuilder.url.(servletPath|scheme|port|serverName)`.

Offline rendering are done by task or scheduled jobs.

Overriden rendering is needed if we want to render the page with an different wicket application.

`APPLICATION_NAME` is the wicket application name (`WebApplication.getName()`). It defaults to
wicket application servlet filter name, but it can be overriden in constructor :

```java
	public ExtranetFront() {
		super();
		this.setName("extranet");
	}
```


### Force mail rendering application context

To force email rendering within a given application (to ensure that absolute URLs are valid):

* override your `I*NotificationContentDescriptorFactory#context(Locale locale)` method
  to provide your own wicket application.

  ```java
  @Override
	protected IExecutionContext context(Locale locale) {
		return getWicketContextProvider().context(extranetFront, locale);
	}
  ```

* setup your wicket application name (used by configuration keys):

  ```java
    public ExtranetFront() {
      super();
      this.setName("extranet");
    }
  ```

* add to your configuration application needed hostname, port, scheme and servletPath configurations

  ```ini
  
  wicket.extranet.backgroundThreadContextBuilder.url.scheme=https
  wicket.extranet.backgroundThreadContextBuilder.url.serverName=domain.com
  wicket.extranet.backgroundThreadContextBuilder.url.serverPort=443
  # servletPath may need to be set if root path is not used
  ```


### Configuration

NotificationBuilder behavior is driven by the following properties:

locale.default

: As each recipient is associated with a preferred locale, `locale.default` is
  used to associate a locale for recipient when raw-email-based methods are
  used to provide To, Cc, Bcc. *INotificationRecipient*-based methods can be
  used to force explicit locale setting.

notification.mail.from

: Fallback for From: address if not set explicitly. Both
  `local-part@domain` and `Personal <local-part@domain>` formats are
  allowed.

notification.mail.sender.behavior (enum)

: **EXPLICIT** | FALLBACK_TO_CONFIGURATION | FALLBACK_TO_FROM

  Control *NotificationBuilder* behavior when sender is not explicitly set.

  - FALLBACK_TO_CONFIGURATION: use `notification.mail.sender` to configure
    sender when it is not set explicitly.
  - FALLBACK_TO_FROM: use current notification From: field to set sender.
  - EXPLICIT: do nothing

notification.mail.sender

: Address used when `notification.mail.sender.behavior=true`. Both
  `local-part@domain` and `Personal <local-part@domain>` formats are
  allowed.

notification.mail.subjectPrefix

: String used to prefix all sent emails. This is usefull to explicitly
  differentiate environments (testing, development). A space is automatically
  added to this prefix.

  :::{note}
  `[Dev]` prefix is automatically added when
  `configurationType=development`
  :::

notification.mail.disabledRecipientFallback

: Address used when a
  `INotificationRecipient#isNotificationEnabled() == false` or does not
  provide an email address.

notification.mail.recipientsFiltered (boolean)

: Use email filtering. All notifications are redirected to addresses listed
  by `notification.test.emails`. A block is added at the start of the
  notification to list the original recipients (To, Cc, Bcc) of the mail.

  This setting is made for testing purpose.

  :::{note}
  `configurationType=development` enforce recipient filtering,
  regardless of this setting.
  :::

notification.test.emails (boolean)

: Space separated list of emails receiving all notifications when
  `notification.mail.recipientsFiltered=true`.

wicket.backgroundThreadContextBuilder.url.(servletPath|scheme|port|serverName)

: servletPath (root path), scheme (http or https), port (80 or 443) and serverName
  to use to generate absolute page URLs. This is default value used when application
  values are not provided (see next entry). This is needed for all wicket HTML
  rendering outside of a wicket request. (if a Wicket context is available, then
  these values are extracted from HTTP request).

wicket.APPLICATION_NAME.backgroundThreadContextBuilder.url.(servletPath|scheme|port|serverName)

: see previous entry. This values allow to override setting by wicket application name.
  Example : it allows to handle extranet and intranet in separated applications, each with
  their own domain name.