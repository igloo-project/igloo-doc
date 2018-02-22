Webjars
=======

Webjars integration relies on:

* **webjars-locator-core** (https://github.com/webjars/webjars-locator-core):
  in default configuration, we strip commons-{codec,compress} and jackson
  dependencies, as they are used only web wbejars extractor that we do not use.
* **wicket-webjars** (https://github.com/l0rdn1kk0n/wicket-webjars)

You can refer to these projects' documentation for advanced use-cases.


Add a webjar dependency
-----------------------

``jar`` dependency type is implied.

.. code-block:: xml

  <dependency>
    <groupId>org.webjars.npm</groupId>
    <artifactId>popper.js</artifactId>
    <version>...</version>
  </dependency>


Construct a resource reference
------------------------------

Use either ``WebjarsJavaScriptResourceReference`` or ``WebjarsCssResourceReference``.
Check webjar content to determine the path to use. The path format is:
``<webjar name>[/<version>]/<resource path>``. ``current`` can be used as a
magic placeholder to use the only available webjars without specifying an
explicit version.

.. code-block:: java

  public final class PopperJavaScriptResourceReference extends WebjarsJavaScriptResourceReference {

  	private static final long serialVersionUID = 1762476460042247594L;

  	private static final PopperJavaScriptResourceReference INSTANCE = new PopperJavaScriptResourceReference();

  	private PopperJavaScriptResourceReference() {
  		super("popper.js/current/dist/umd/popper.js");
  	}

  	public static PopperJavaScriptResourceReference get() {
  		return INSTANCE;
  	}

  }

.. note:: to search available webjars: https://www.webjars.org/. Be aware that
  webjars can contain only final artifacts (scss compiled or transpiled
  javascript) or source artifacts (scss or unprocessed javascript). Choose the
  right resource for your usage.

Sass @import
------------

Webjars resource import with bootstrap is possible with the following url
pattern:

``@import "webjars://<webjar name>[/<version>]/<resource path>";``

As an example:

``@import "webjars://bootstrap:4.0.0/scss/variables";`` (explicit version)

``@import "webjars://bootstrap:current/scss/variables";`` (wicket-webjars *current* magic version)

``@import "webjars://bootstrap/scss/variables";`` (no version)

.. note:: webjar import handling is done with ``org.iglooproject.wicket.more.css.scss.service.JSassClassPathImporter``.
  **current magic version** support is added here to mimic wicket-webjars behavior.
