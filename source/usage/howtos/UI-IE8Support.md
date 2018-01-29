# UI IE 8 Support

A reasonable, transparent IE8 support can be achieved in a Wicket application the following way.

Obviously, you'll still run into slowdowns, bugs and limitations due to IE8 being IE8. But the most visible issues will be gone.

## 1. Add IE8-specific CSS
Put these files beside your `StylesLessCssResourceReference.java`:

`IE8AndLesserLessCssResourceReference.java`:
```java
public final class IE8AndLesserLessCssResourceReference extends LessCssResourceReference {

	private static final long serialVersionUID = 4656765761895221782L;

	private static final IE8AndLesserLessCssResourceReference INSTANCE = new IE8AndLesserLessCssResourceReference();

	private IE8AndLesserLessCssResourceReference() {
		super(IE8AndLesserLessCssResourceReference.class, "ie8-and-lesser.less");
	}

	public static IE8AndLesserLessCssResourceReference get() {
		return INSTANCE;
	}

}
```

`ie8-and-lesser.less`:
```java
@import "@{scope-core-bs3}bootstrap/variables.less";
@import "@{scope-core-bs3}bootstrap/override/variables.less";
@import "variables.less";

.placeholder { // Added by the "placeholder" jquery polyfill plugin. See jquery.placeholder.js
	color: @input-color-placeholder;
}

.btn-icon-only.btn-placeholder, .btn-placeholder {
	visibility: hidden;
}

/* Put any IE8-specific CSS here */

```

## 2. Add global listeners

Add this in your Wicket Application's `init` method:

```java
IELegacySupport.init(this);
```

With `IELegacySupport.java` being:
```java
public final class IELegacySupport {

	private IELegacySupport() {
	}

	public static final String IE_LEGACY_CONDITION = "lte IE 8";

	public static final String IE_UNSUPPORTED_CONDITION = "lt IE 8";

	public static final String IE_8_CONDITION = "IE 8";

	public static final int IE_LEGACY_VERSION = 8;

	public static void init(WebApplication webApplication) {
		webApplication.getComponentInstantiationListeners().add(new InstantiationListener());
		webApplication.getAjaxRequestTargetListeners().add(new AjaxRequestTargetListener());
	}

	private static class IELegacyHeaderItemsContributorBehavior extends Behavior {

		private static final long serialVersionUID = -1441191136903604013L;

		private final Iterable<HeaderItem> headerItems;

		public IELegacyHeaderItemsContributorBehavior(HeaderItem ... headerItems) {
			this(ImmutableList.copyOf(headerItems));
		}

		public IELegacyHeaderItemsContributorBehavior(Iterable<HeaderItem> headerItems) {
			super();
			this.headerItems = headerItems;
		}

		@Override
		public void renderHead(Component component, IHeaderResponse response) {
			WebClientInfo clientInfo = (WebClientInfo) Session.get().getClientInfo();
			ClientProperties properties = clientInfo.getProperties();
			if (properties.isBrowserInternetExplorer() && properties.getBrowserVersionMajor() <= IE_LEGACY_VERSION) {
				for(HeaderItem headerItem : headerItems) {
					response.render(headerItem);
				}
			}
		}
	}

	private static class InstantiationListener implements IComponentInstantiationListener {
		@Override
		public void onInstantiation(Component component) {
			if (component instanceof Page) {
				Page page = (Page) component;

				// Support for the placeholder text of input fields in IE8 and lesser
				page.add(new PlaceholderPolyfillBehavior());

				page.add(new IELegacyHeaderItemsContributorBehavior(
						// Support for media queries in IE8 and lesser
						JavaScriptHeaderItem.forReference(RespondJavaScriptResourceReference.get()),
						// IE8 and lesser specific CSS
						CssHeaderItem.forReference(IE8AndLesserLessCssResourceReference.get())
				));
			}
		}
	}

	private static class AjaxRequestTargetListener extends AjaxRequestTarget.AbstractListener {
		@Override
		public void updateAjaxAttributes(AbstractDefaultAjaxBehavior behavior, AjaxRequestAttributes attributes) {
			WebClientInfo clientInfo = (WebClientInfo) Session.get().getClientInfo();
			ClientProperties properties = clientInfo.getProperties();
			if (properties.isBrowserInternetExplorer() && properties.getBrowserVersionMajor() <= IE_LEGACY_VERSION) {
				attributes.getAjaxCallListeners().add(
						new AjaxCallListener().onBefore(
								// Prevents placeholder text from being submitted
								PlaceholderPolyfillBehavior.disable().render()
						)
				);
			}
		}

		@Override
		public void onBeforeRespond(Map<String, Component> map, AjaxRequestTarget target) {
			// Refresh the placeholder text (for instance when rendering a popup)
			target.appendJavaScript(PlaceholderPolyfillBehavior.statement().render());
		}

		@Override
		public void onAfterRespond(Map<String, Component> map, IJavaScriptResponse response) {
			// Nothing to do
		}
	}

}
```
