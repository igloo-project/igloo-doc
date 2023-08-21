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
