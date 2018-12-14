############
Wicket Tests
############

The test of Wicket elements and the construction of Wicket pages can be done via ``WicketTester``.
It provides utilitary methods to assert certain facts on components.
We also provide additionnal methods with a ``CoreWicketTester`` and a ``WicketMoreWicketTester``.

Initialization
##############

To start creating tests for your application you should reproduce the organization of Basic Application's webapp module by adding a ``src/test/java``` and ```src/test/resource`` folder.
Make sure to update the ``pom.xml`` of your webapp module and also from your core module (the plugin ``maven-jar-plugin`` is mandatory).

You should have a local WicketTester, ``[Project]WicketTester`` and an abstract test case class. See ``BasicApplicationWicketTester`` and ``AbstractBasicApplicationWebappTestCase``.

Usage
#####

Data initialization
*******************

All data must be initialized before each test and cleaned afterwards. These two steps must be implemented in your abstract test case.
Two mandatory elements :

* During the initialization phase, you must also initialize a new tester (see ``AbstractBasicApplicationWebappTestCase#setUp()``).
* After the data being cleaned you must call ``emptyIndexes()`` method. It ensures your indexes to be well cleaned even after an abrupt stop of your tests.

Setup of a test
***************

At the beginning of your test you have to load the page you want to test.

WicketTester bypasses Spring security, so every pages protected only in your ``security-web-content.xml`` won't be protected in your tests.

However, pages protected by a ``@AuthorizeInstantiation`` are well protected and only the authorized user will be able to access these pages.
So you must authenticate yourself with the right user to access those pages.
You should copy the pattern present in the Basic Application and use the ``authenticateUser()`` method.

Once you are authenticated, you can launch the page using ``WicketTester#startPage(Class)`` or ``WicketTester#executeUrl(String)``.

From now it is up to you and your test scenario.

Assertions
**********

All assertions methods check the behavior of a wicket element. You can either provide the element itself or the **path** to access it.

The **path** correspond to the element's ``wicketId``. From a page, only the direct child are accessible. If you want to test a label inside a panel added to a
page, the path to the label from the page is ``panelwicketId:labelWicketId``.

Common
======

We have multiple methods provided directly by WicketTester itself to test if the elements are visible, invisible, enabled, disabled, etc.

``CoreWicketTester`` - It provides utilitary methods similar to those from WicketTester.
``WicketMoreWicketTester`` - It provides methods to test wicket more components.

* ``assertEnabled`` : the basic method only checks that the element is enabled, this behavior is override in ``CoreWicketTester`` to check also its visibility.
* ``assertDisabled`` : the basic method only checks that the element is disabled, this behavior is override in ``CoreWicketTester`` to check also its visibility.
* ``assertUsability`` : this method comes directly from ``BaseWicketTester`` (``WicketTester`` super class).
  Contrary to assertion methods provided from ``WicketTester`` it can only be used with a component and doesn't support the path access. To ensure consistency between
  all methods we provide these methods. You won't have the use of this method knowing that it provides the same behavior than the ``assertEnabled`` methods.

.. note::

  For the basic methods (visible, enabled, disabled, usability) a other endpoint that also check the component's type is provided. The assertion ``assertComponent`` is used
  to do so.

  For example : ``assertVisible("labelWicketId", CoreLabel.class)`` It ensures that the component corresponing to the wicketId "labelWicketId" is visible and of type CoreLabel.

* ``assertRenderedPage`` : to check the page we are currently
* ``assertFeedbackMessages`` : to assert the content of feedback messages

Navbar
======

To test your navbar you can reproduce the pattern in ``HomePageTestCase#navbarUserAdmin()``.
Calling the ``navbar(int)`` you have to provide the number of expected tabs including the submenu.

To adapt this pattern to your application you only have to modify the NavbarItem by adding or removing tabs.

Forms
=====

In order to fill form and submit it you have to create a ``FormTester`` from ``Form`` component.
Here is an example :

.. code-block:: java

  FormTester form = tester.newFormTester("content:form");

  form.setValue(form.getForm().get("username"), "usernameExample");
  form.setValue(form.getForm().get("password"), "passwordExample");

  form.submit();

Depending on the type of field several method are provided

* ``FormTester#setValue`` : for text field
* ``FormTester#select(String, int)`` : for select field
* ``FormTester#setFile`` : for file upload field

For the submission either you provide the component to use or you let the newFormTester
determine it himself. It will only work if the submit button is included in the Form Component, which generally is not the case in modal.

Test Html pages
===============

It is possible to directly control the construction of the html pages via a ``TagTester`` object.

Navigation
**********

To navigate between pages you can simulate a mouse click with the method ``WicketTester#clickLink(Component)``

Limits
******

WicketTester does not interprete Ajax callback or JavaScript callback so every component such as ``UserAjaxDropDownSingleChoice`` cannot be tested.
