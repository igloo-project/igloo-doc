# UI Redirecting

This page explains various methods for redirecting from one page to another in you web application.

Please note that we're talking about redirection as part of a server-side process, such as a form that redirects to a different page based on the user input. If you just want a link in your HTML page, please see [UI-Links](UI-Links.html).

## Redirecting as part of the authentication/authorization process

### Basics

When some page is accessed, but the current user has no right to access it (either because the user is not authenticated or he hasn't got the proper authorization), Igloo throws a `org.springframework.security.access.AccessDeniedException`, which is caught by Spring Security's servlet filter. Spring Security then handles this exception with whatever behavior you configured; by default in Igloo, it's a redirection to "/access-denied/", on which the `AccessDeniedPage` is mapped.

`AccessDeniedException`s are thrown:

 * When Spring Security detects an unauthenticated access (access to a page without authorization while being unauthenticated).
 * When a Wicket's `AuthorizationException` is caught by the `CoreDefaultExceptionMapper`.

### Customizing the general behavior

If you want to customize the behavior when an access is denied, you should either:

 * change Spring Security's configuration to customize the access denied handler
 * map your own page to "/access/denied/"

### Customizing the behavior for specific pages

If you want to customize the behavior for specific pages, you may do so:

 * at the Wicket level, by declaring your own exception mapper by overriding `org.apache.wicket.Application.getExceptionMapperProvider()` and defining a specific behavior when an `AuthorizationException` is caught. Be aware that this will not cover cases when an access is denied by Spring Security, though, only cases when an access is denied by Wicket itself (due to an annotation on a page, for instance).

   This can be done this way (for instance) in the `map` method of a class extending `CoreDefaultExceptionMapper` :

   ```
		try {
			if (
					Exceptions.findCause(e, AccessDeniedException.class) != null
				||	Exceptions.findCause(e, AuthorizationException.class) != null
			) {
				IPageRequestHandler handler = PageRequestHandlerTracker.getFirstHandler(RequestCycle.get());
				Class<? extends IRequestablePage> pageClass = handler.getPageClass();
				PageParameters pageParameters = handler.getPageParameters();
				Component component = null;
				if (handler instanceof IComponentRequestHandler && ((IComponentRequestHandler) handler).getComponent() instanceof Component) {
					component = (Component) ((IComponentRequestHandler) handler).getComponent();
				}
				if (
						IMyPageWhoseAccessMayBeDenied.class.isAssignableFrom(pageClass)
					||	(component != null && IMyPageWithAPopupWhoseAccessMayBeDenied.class.isAssignableFrom(pageClass))
				) {
					Session.get().error(rendererService.localize("access.denied.customMessage", Session.get().getLocale()));
					PageParameter parameters = /* ... */;
					return new RenderPageRequestHandler(new PageProvider(MyRedirectPage.class, ));
				}
		} catch (RuntimeException e2) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.error("An error occurred while handling a previous error: " + e2.getMessage(), e2);
			}

			// We were already handling an exception! give up
			LOGGER.error("unexpected exception when handling another exception: " + e.getMessage(), e);
			return new ErrorCodeRequestHandler(500);
		}

		return super.map(e);
   ```
 * or at the Spring Security level by defining your own access denied handler in Spring Security's configuration

## Redirecting to the current page

### Full refresh (keeping the same page instance)

If you're in a non-Ajax component, know that handling the request will automatically trigger a full-page refresh. No need for you to do anything.

In the context of an Ajax component you may use this snippet in order to fully refresh the current page:

```
target.add(getPage());
```

Or if you want to completely abort your currently executing code, you may throw an exception:

```
throw new RestartResponseException(getPage());
```

### Redirecting to another instance of the same page

In some cases, you will want to redirect to another instance of the same page with the same parameters. This is mostly used when a fatal error occurs.

```
throw new RestartResponseException(getPage().getClass(), getPage().getPageParameters());
```

## For any other redirection (most cases)

Redirection is mainly done through exceptions. These come in various flavors, depending on your redirection target.

Please note that `IPageLinkGenerator`s (see [UI-Links](UI-Links.html)) offer methods for easily generating the exception of your choice. This is the recommended way of redirecting.

Here are the main exception types:

 * `RestartResponseException` when you simply want to redirect to another page in your Wicket application.
 * `RestartResponseAtInterceptPageException` when you want to redirect to another page which will later trigger another redirection to the current page (mainly used for sign-in pages).
 * `RedirectToUrlException` when you want to redirect to an external URL (outside of your Wicket application).

You may also encounter the following patterns in Wicket components or pages. These should be avoided, as they only throw an exception but they do not make it clear, neither to you nor to the compiler. Thus you may end up with dead code after your `redirect` call.

```
// AVOID THIS
redirect(MyPage.class);
```

```
// AVOID THIS
redirectToInterceptPage(MyPage.class);
```

### Adding an anchor

If you want to point to an anchor on the target page, then you must use a `RedirectToUrlException`. This feature is built in the `IPageLinkGenerator`.
