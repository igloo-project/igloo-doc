########
Releases
########

.. _v1.y.z:

1.y.z (yyyy-mm-dd)
###################

Highlights
**********

* Breaking change: Configuration system is modified to
  replace custom @ConfigurationLocations system by spring vanilla
  @PropertySource. See :ref:`property-source-migration` to find how to modify
  your application and check that configuration is correctly managed.
  (TODO: rewrite 1.y.z in documentation to appropriate version)

.. _v1.3.0:

1.3.0 (yyyy-mm-dd)
##################

Breaking changes
****************

* ``DataTableBuilder``: ``.addRowCssClass(...)`` has been removed. Use
  ``.rows().withClass(...).end()`` instead with proper indentation.

Bugfixes
********

* BasicApp: preload scss file for both themes.

Enhancements
************

* Add ``table-layout`` css classes.
  Usage : ``table-layout{-sm|-md|-lg|-xl}-(auto|fixed)``
* ``DataTableBuilder``: row item model dependant behaviors and css classes
  on rows and actions columns elements + single element.

  .. code-block:: text

    - IBuildState#addRowCssClass(IDetachableFactory<? super IModel<? extends T>, ? extends String>);
    - IActionColumnAddedElementState#withClass(String);
    - IActionColumnCommonBuildState#withClassOnElements(String);

  .. code-block:: text

    + IDataTableRowsState#add(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>>);
    + IDataTableRowsState#add(IDetachableFactory<? super IModel<? extends T>, ? extends Behavior> rowsBehaviorFactory);
    + IDataTableRowsState#add(Behavior, Behavior...);
    + IDataTableRowsState#withClass(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IDataTableRowsState#withClass(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IDataTableRowsState#withClass(IModel<? extends String>);
    + IDataTableRowsState#withClass(String, String...);
    + IDataTableRowsState#end();

    + IActionColumnAddedElementState#withClass(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IActionColumnAddedElementState#withClass(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IActionColumnAddedElementState#withClass(IModel<? extends String>);
    + IActionColumnAddedElementState#withClass(String, String...);
    + IActionColumnAddedElementState#add(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>>);
    + IActionColumnAddedElementState#add(IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>);
    + IActionColumnAddedElementState#add(Behavior, Behavior...);

    + IActionColumnCommonBuildState#withClassOnElements(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IActionColumnCommonBuildState#withClassOnElements(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IActionColumnCommonBuildState#withClassOnElements(IModel<? extends String>);
    + IActionColumnCommonBuildState#withClassOnElements(String, String...);

.. _v1.2.0:

1.2.0 (2019-09-05)
##################

Updates
*******

* Font Awesome 5.10.1 -> 5.10.2

Enhancements
************

* Add ``BootstrapCollapseBehavior`` to easily enable BS collapse plugin on
  components.
* BasicApp: sidebar is automatically displayed if there is enough space.
* BasicApp: add ``-webkit-overflow-scrolling: touch`` on sidebar.

.. _v1.1.28:

1.1.28 (2019-08-30)
###################

Breaking changes
****************

* ``QueuedTaskHolder``: remove ``CREATION_DATE_SORT``, ``TRIGGERING_DATE_SORT``,
  ``START_DATE_SORT`` and ``END_DATE_SORT``. Use fields without ``_SORT``
  suffix. **Warning**: ``QueuedTaskHolder`` needs to be reindexed.

Updates
*******

* Bootstrap 3.3.6 -> 3.4.1
* Font Awesome 5.9.0 -> 5.10.1
* Popper.js 1.14.7 -> 1.15.0
* BS4: Select2 4.0.5 -> 4.0.9
* BS3: Select2 4.0.3 -> 4.0.9
* BS3: select2-bootstrap-theme 0.1.0-beta.8 -> 0.1.0-beta.10

Enhancements
************

* Add ``list-group-sub`` css class.

Bugfixes
********

* BS4 modal: remove fade animation on close.
* BS4 tooltip: set ``window`` as default ``boundary`` instead of ``viewport``.
* BS4 select2: remove options tooltip.
* BS3 select2: update tab key behavior.
* Hibernate Search: use Lucene ``missingValue`` parameter on HS field context.

.. _v1.1.27:

1.1.27 (2019-07-26)
###################

Highlights
**********

* BasicApp: Update basic and advanced layouts + consistency.
  Revamp sidebar (style and positioning) in advanced layout.
* Add build tool **Autoprefixer**: css prefixes like ``-webkit-``, ``-moz-``,
  ``-ms-``, ``-o-``, etc. are automatically added if needed.
* Added PropertySourceLogger, for debugging/maintenance purpose.

Breaking changes
****************

* Drop Igloo Infinispan maven module.

Bugfixes
********

* ``FilterByModelItemModelAwareCollectionModel``: Use copy of ``unfiltered``
  (iterator) to avoid concurrent modification exceptions.
* ``AbstractJpaSearchQuery``: Method ``containsIfGiven`` use
  ``CollectionPathBase`` instead of ``CollectionPath`` to allow ``SetPath``
  and ``ListPath``.
* Fix wicket-more-jqplot ``pom.xml`` to embed Js files. May fix "resource
  not found" messages when using JQPlot charts.
* Feedback panel (BS4): fix unwanted overlay preventing users to interact with
  the bottom (or top) of the page.

.. _v1.1.26:

1.1.26 (2019-07-03)
###################

Bugfixes
********

* Transaction synchronization: ``unbindContext()`` must be called in a finally
  block. Otherwise, in rare case where previous call ``doOnRollback()`` throw
  an error, context will be bind for the current thread forever. If really
  needed, the new context will not be bind in future (for the same thread).

Enhancements
************

* Announcement: various enhancements and bugfixes.

Updates
*******

* Font Awesome 5.8.1 -> 5.9.0

.. _v1.1.25:

1.1.25 (2019-06-11)
###################

Bugfixes
********

* ``FilterByModelItemModelAwareCollectionModel``: Fix ``size`` method to use
  the filtered iterable instead of using the unfiltered model size.

Enhancements
************

* BS3 affix js: check position on dom ready.

.. _v1.1.24:

1.1.24 (2019-05-03)
###################

Updates
*******

.. warning::
  - **wicket-webjars**: bug in latest versions from 2.0.11 to 2.0.14,
    don't use them.

  - **wicket** and **wicketstuff-select2**: bug in latest version 8.3.0 in
    wicketstuff-select2 dependency.

* **spring-core 5.1.4.RELEASE -> 5.1.6.RELEASE**
* **hibernate-core 5.4.1 -> 5.4.2**
* hibernate-validator 5.4.2 -> 5.4.3
* wicket-webjars 2.0.8 -> 2.0.10
* webjars-locator-core 0.35 -> 0.37
* spring-security 5.1.3.RELEASE -> 5.1.4.RELEASE
* flying-saucer-pdf 9.1.16 -> 9.1.18
* guava 27.0-jre -> 27.1-jre
* commons-codec 1.11 -> 1.12
* jsass 5.7.3 -> 5.7.4
* aspectjrt 1.9.1 -> 1.9.2
* aspectjweaver 1.9.1 -> 1.9.2
* jsch 0.1.54 -> 0.1.55
* slf4j 1.7.25 -> 1.7.26
* cglib-nodep 3.2.8 -> 3.2.10
* ph-css 4.1.3 -> 6.1.2
* HikariCP 3.2.0 -> 3.3.1
* commons-collections4 4.2 -> 4.3
* commons-fileupload 1.3.3 -> 1.4
* commons-configuration2 2.3 -> 2.4
* httpcore 4.5.6 -> 4.5.7
* httpclient 4.4.10 -> 4.4.11
* assertj 3.11.1 -> 3.12.2
* assertj-guava 3.2.0 -> 3.2.1
* elasticsearch 5.6.9 -> 5.6.10
* elasticsearch-cluster-runner 5.6.9.0 -> 5.6.10.0
* flywaydb 5.0.7 -> 5.2.4
* javassist 3.24.0-GA -> 3.24.1-GA
* passay 1.3.1 -> 1.4.0
* allure-junit4 2.8.1 -> 2.10.0
* ehcache 2.10.6 -> 2.10.6.5.1
* allure-maven 2.9 -> 2.10.0
* mockito-core 2.23.0 -> 2.25.1
* jackson 2.9.7 -> 2.9.8
* h2database 1.4.197 -> 1.4.199
* maven-javadoc-plugin 3.0.1 -> 3.1.0
* jacoco-maven-plugin 0.8.0 -> 0.8.3
* maven-assembly-plugin 3.1.0 -> 3.1.1
* maven-clean-plugin 3.0.0 -> 3.1.0
* maven-compiler-plugin 3.7.0 -> 3.8.0
* maven-dependency-plugin 3.0.2 -> 3.1.1
* maven-deploy-plugin 2.8.2 -> 3.0.0-M1
* maven-enforcer-plugin 3.0.0-M1 -> 3.0.0-M2
* maven-install-plugin 2.5.5 -> 3.0.0-M1
* maven-failsafe-plugin 2.21.0 -> 3.0.0-M3
* maven-jar-plugin 3.0.2 -> 3.1.1
* maven-resources-plugin 3.0.2 -> 3.1.1
* maven-surefire-plugin 2.21.0 -> 3.0.0-M3
* maven-war-plugin 3.2.1 -> 3.2.2
* animal-sniffer-maven-plugin 1.16 -> 1.17
* wagon-maven-plugin 1.0 -> 2.0.0
* wagon-ssh-external 3.2.0 -> 3.3.1

Dependencies deleted
********************

* pgjdbc-ng
* solr-core

Enhancements
************

Added `Owasp Dependency-Check and Versions maven plugin`_ for maven dependencies.

.. _Owasp Dependency-Check and Versions maven plugin: ../usage/howtos/owasp-maven-versions-plugin.html

Refactor basic-application java configuration, now uses a `custom Spring-boot annotation`_.

.. _custom Spring-boot annotation: ../usage/howtos/spring-boot.html

.. _v1.1.23:

1.1.23 (2019-03-04)
###################

Enhancements
************

* Excel init data: fallback on old xls format to avoid breaking change.

.. _v1.1.22:

1.1.22 (2019-03-04)
###################

Breaking changes
****************

* Refactor ``ReferenceData``:

  * Remove ``*Simple*ReferenceData*`` classes and references.
  * Rename ``*Localized*GenericReferenceData*`` classes and references to
    ``*GenericReferenceData*``
  * BasicApp: Rename ``*LocalizedReferenceData*`` classes and references to
    ``*ReferenceData*``.
  * BasicApp: Rename ``*Simple*ReferenceData*`` classes and references to
    ``*Basic*ReferenceData*``.

Enhancements
************

.. warning::

  This is a unwanted breaking change. Use 1.1.23 instead to keep using the old
  xls format.

* Excel init data: use xlsx format instead of xls.

.. _v1.1.21:

1.1.21 (2019-03-29)
####################################

Updates
*******

* Bootstrap 4.2.1 -> 4.3.1
* Font Awesome 5.7.0 -> 5.8.1
* popper.js 1.14.6 -> 1.14.7

Bugfixes
********

* BasicApp: Fix ``UserPasswordValidator`` to check the username rule. It now
  has to be added to a ``ModelValidatingForm`` instead of a ``Form``.
* BasicApp: Fix email check on password reset page.

Enhancements
************

* Select2: override BS theme to make multiple selection choices more responsive.

.. _v1.1.20:

1.1.20 (2019-03-22)
###################

Bugfixes
********

* Fix Hibernate Search sort util to deal with score sort.
* Fix condition for ``notEmpty`` and ``mapNotEmpty`` predicates.

Enhancements
************

* BS3 module:

  * Custom Select2 4.0.3 js file.
  * Update Select2 Bootstrap 3 theme and clean up override.
  * Update JQuery UI to 1.12.1 with custom js and css files.
  * Change pagination default size (small) in panel add-in.
  * Update logo on console sign in page.
  * Change modal backdrop style.
  * Fix popover html template.


.. _v1.1.19:

1.1.19 (2019-02-25)
###################

Updates
*******

* Bindgen 4.0.1 -> 4.0.2

Enhancements
************

* Update and fix footer layout on BasicApp and console template.

.. _v1.1.18:

1.1.18 (2019-02-13)
###################

Updates
*******

* Hibernate 5.3.7 -> 5.4.0
* Hibernate 5.10.4 -> 5.11.0
* Spring 5.0.10 -> 5.1.4
* Spring security 5.0.9 -> 5.1.3
* Font Awesome 5.6.3 -> 5.7.0

Hibernate & JAXB dependencies
-----------------------------

From 5.4.0, Hibernate includes JAXB dependencies in pom.xml, so this new release
transitively includes javax.xml.bind:jaxb-api and org.glassfish.jaxb:jaxb-runtime
(and transitive dependencies). Please check your dependencies.

Enhancements
************

* Improve inclusion of tables into cards with new custom css classes (``.table-bordered-inner``, ``.table-card-body``, ``.card-body-table``).
  From now on every content in a ``card`` should be placed under a ``card-body`` element.
* Add new method ``replaceAll`` in ``CollectionUtils`` utilitary to provide the transformation to operate on the reverse collection.
* Creation of a new Igloo module, ``igloo-component-jpa-more-test``, that was originally included in ``igloo-component-jpa-more``. It includes utilitaries for tests
  and all tests present in ``igloo-component-jpa-more`` ``src/test`` package.
* Select2: Override ``ChoiceProvider`` to add ``offset`` and ``limit`` parameters to ``query`` method.
  Also, compute ``hasMore`` attribut for ajax response.

.. _v1.1.17:

1.1.17 (2019-01-04)
###################

Updates
*******

 * Bootstrap 4.1.3 -> 4.2.1
 * Font Awesome 5.6.1 -> 5.6.3

.. _v1.1.16:

1.1.16 (2018-12-28)
###################

Bugfixes
********

* Fix partial reindexation form not submitted.
* BasicApp: fix email in import excel files.

Breaking changes
****************

* Update scss custom grid:

  * Remove ``.row-default`` and ``.row-compact``, use ``.row-md`` and ``.row-xs`` instead.
  * Change ``$grid-gutter-widths`` to ``$grid-gutters`` and update keys from ``(0, 1, 2, 3, 4, 5, 6)`` to ``(0, xxs, xs, sm, md, lg, xl, xxl)``.
  * Add ``$layout-container-padding-x`` for consistency across containers in page sections.
  * Revamp css for description parts (label-value display).

Updates
*******

* Allure (test reports) updated to version 2.8.1

.. _v1.1.15:

1.1.15 (2018-12-14)
###################

Bugfixes
********

* Fix :issue:`16` Webjars - too many open files

Updates
*******

* Font Awesome 5.5.0 -> 5.6.1
* Wicket Stuff Select2 8.1.0 -> 8.2.0
* Apache POI 4.0.0 -> 4.0.1
* Popper.js 1.14.4 -> 1.14.6
* Clipboard.js 2.0.1 -> 2.0.4

Enhancements
************

* BasicApp: consistent use of default locale french.
* BasicApp: refactor users admin pages.
* BasicApp: add tabs in user detail pages.

WicketTester
************

WicketTester mecanism has been improved by providing new utilitary methods and
somes modules were refactored in that way.

.. _v1.1.14:

1.1.14 (2018-12-03)
###################

Enhancements
************

* Bootstrap Modal changes:

  * Use custom js file ``modal-more.js`` to override modal behavior.
  * Move ``_enforceFocus`` method override in ``modal-more.js``.
  * Override ``show`` and ``hide`` methods to move modal to body on show
    and put it back to its parent on hide.
  * Override ``show`` and ``hide`` methods to force modal to close on
    transition.
  * Remove custom ``modal.js`` override, no longer needed.

* BasicApp: minor scss updates.

.. _v1.1.13:

1.1.13 (2018-11-23)
###################

Bugfixes
********

* Fix Apache POI dependency: add missing commons-math3.
* Remove from html useless confirm modal on hidden event.
* BasicApp: add missing visible condition on navbar submenu items.

.. _v1.1.12:

1.1.12 (2018-11-19)
###################

.. warning::
  Apache POI 4.0.0: dependency ``commons-math3`` is missing.
  Use Igloo 1.1.13 instead or add the dependency locally.

Bugfixes
********

* Add missing Bootstrap Util js dependency for Bootstrap Modal js.

Updates
*******

* Wicket 8.1.0 -> 8.2.0

  * https://wicket.apache.org/news/2018/11/17/wicket-8.2.0-released.html

* javax.mail:mail 1.4.7 updated to com.sun.mail:javax.mail 1.6.2

  * javax.mail:mail added as a forbidden dependency
  * igloo-component-spring dependency modified to com.sun.mail:javax.mail
  * if you declare your own javax.mail:mail dependency in you project, please
    update groupId/artifactId with com.sun.mail/javax.mail

* poi 3.17.0 updated to poi 4.0.0; there's some breaking change that are not
  involved in API used by Igloo

  * http://poi.apache.org/changes.html#4.0.0

* Font Awesome 5.3.1 -> 5.5.0

  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.0
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.1
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.2
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.5.0

* Bindgen 4.0.0 -> 4.0.1

Enhancements
************

* BasicApp: fix reference data permission check on add action.
* BasicApp: add build date and commit sha in footer.

WicketTester
************

* The use of ``WicketTester`` has been added to the BasicApplication. For now it's
  more a showcase and does not present an entire test coverage.
* This development required to create a new Igloo module,
  ``igloo-component-wicket-more-test``, that was originally included in
  ``igloo-component-wicket-more``.
* Note that the version of ``igloo-component-jpa-test`` has been declared globally,
  so it should not be present in project pom anymore.

.. _v1.1.11:

1.1.11 (2018-11-06)
###################

.. warning::
  Wicket 8.1.0 websocket implementation is broken wicket Tomcat 8.5+
  (https://github.com/apache/wicket/commit/5fc86bdd8628686ffcd124849750f327dccc0c77#diff-94114697955d73acae40bf0a21c6b961)
  Please do not update if you use websocket.

Bugfixes
********

* Fix Select2 focus and dropdown results position in Bootstrap Modal.

.. _v1.1.10:

1.1.10 (2018-10-29)
###################

Dependencies
************

* Major updates:

  * hibernate 5.3.5 -> 5.3.17, hibernate-search 5.10.3 -> 5.10.4
  * spring 5.0.7 -> 5.0.10, spring-security 5.0.6 -> 5.0.9
  * wicket 8.0.0 -> 8.1.0

.. warning::
  Wicket 8.1.0 websocket implementation is broken wicket Tomcat 8.5+
  (https://github.com/apache/wicket/commit/5fc86bdd8628686ffcd124849750f327dccc0c77#diff-94114697955d73acae40bf0a21c6b961)
  Please do not update if you use websocket.

* Details:

  * https://github.com/igloo-project/igloo-parent/commit/5fbfce45d2ea92c340dff6107c24a2de0e28e19b
  * https://github.com/igloo-project/igloo-parent/commit/80563f1a097d46fae2c3dfc310966265ecbf46db
  * https://github.com/igloo-project/igloo-parent/commit/d4c3a13fc28ff46c0802f3443b17940c01cb235a
  * https://github.com/igloo-project/igloo-parent/commit/e4107081d829c3f36106674fa778ba771a69d94f
  * https://github.com/igloo-project/igloo-parent/commit/d082937880f43dd076fd7615f15a902aaa00140b

.. _v1.1.9:

1.1.9 (2018-10-29)
##################

Bugfixes
********

* Fix JQuery UI datepicker absolute top position.
* Fix condition on edit button for ``ReferenceData`` list pages.

Enhancements
************

* Move Wicket JavaScript and Select2 custom settings to
  ``CoreWicketApplication``.
* Add announcement feature into BasicApp.
* Update error pages (403, 404, 500, 503).

Breaking changes
****************

* ``DataTableBuilder``: rename method
  ``when(SerializablePredicate2<? super T> predicate)`` to
  ``whenPredicate(SerializablePredicate2<? super T> predicate)``.


.. _v1.1.8:

1.1.8 (2018-10-11)
##################

Bugfixes
********

* Fix conflict between Bootstrap 4 tooltip and JQuery UI widget tooltip.

Breaking changes
****************

* Override JQuery UI js ressource from WiQuery to remove widget tooltip.

.. _v1.1.7:

1.1.7 (2018-10-10)
##################

Bugfixes
********

* Fix inline enclosure component handler in BS modal.
* Fix limit 0 case in QueryDSL and HS search query (return empty list).

Breaking changes
****************

* Custom Wicket tag ``wicket:enclosure-container`` is now deprecated and will be
  removed soon. Use Igloo component ``EnclosureContainer`` instead.

Enhancements
************

* added tests on rollback behavior in ``igloo-component-jpa-test``

.. _v1.1.6:

1.1.6 (2018-10-01)
##################

Bugfixes
********

* Select2: attach component to the Bootstrap modal.

Breaking changes
****************

* Fix Bootstrap variables override.

.. _v1.1.5:

1.1.5 (2018-09-24)
##################

Bugfixes
********

* Select2: prevent dropdown toggle (open) on clear (single + multiple).
* Select2: dispose tooltip on element clear (multiple).

Updates
*******

* Font Awesome 5.3.1.

Enhancements
************

* Add build informations (date, commit sha, etc.).
* Consistency in use of Wicket ``Session.get()``.
* Remove useless icon on cancel buttons.
* BasicApp: Fix custom BS checkbox position.
* BasicApp: Improve alignment on page title and back to btn.
* BasicApp: Minor change on style (nav and pagination background colors).
* BasicApp: Remove useless link to user detail page.

.. _v1.1.4:

1.1.4 (2018-09-16)
##################

Bugfixes
********

* :issue:`18` - fix grouping/splitting behavior when sending a notification to
  multiple recipients.
* :issue:`17` - use an explicit setting ``notification.mail.sender.behavior``
  to control what is done when sender is not explictly set when a mail is sent.
  Get rid of an extraneous INFO message on PropertyServiceImpl when
  ``notification.mail.sender`` is empty.

Breaking changes
****************

If you use a not-empty value for ``notification.mail.sender``, you need to
add to your configuration
``notification.mail.sender.behavior=FALLBACK_TO_CONFIGURATION``.

.. _v1.1.3:

1.1.3 (2018-09-12)
##################

Bugfixes
********

* Fix off-request wicket generation (scheduler, async tasks). The issue broke
  all wicket-based API used outside of an HTTP request.
* Fix a problematic dependency declaration on igloo-dependency-hibernate-search
  that triggers (wrongly) SNAPSHOT detection by jgitflow plugin.

.. _v1.1.2:

1.1.2 (2018-09-06)
##################

Enhancements
************

This changes are backward-compatible.

* added JNDI's database support (:ref:`jndi`)
* added ``igloo.config`` and ``igloo.log4j`` configuration overrides
  (:ref:`config.bootstrap`)
* drop some useless WARN messages
* AuthenticationManager now uses Spring to search AuthenticationProvider
  (instead of a static configuration).

Bugfixes
********

* fix logger's configuration overriding (higher precedence for last files).

Misc
****

* update developers' information (pom.xml)

.. _v1.1.1:

1.1.1 (2018-09-03)
##################

Enhancements
************

* [4747e20056678ae7300272a6bf9dd39d38ba7b9a] added !default on some styles
* [713cc732fce44c5b26e3cf9e46abf5aebcacb9c3] update some data for Excel-based
  initialization
* [c28ed4fccd9a25481123da2db48d34d54c031a98] basic-application: use raw
  bootstrap grid styling instead of custom styles
* [df3bcdb1f215e7005efba0fefcde751064bddb0b] prepare bootstrap-override
  resources to ease fix and workaround integration in Igloo on external styling
  resources (bootstrap, ...).

Bugfixes
********

* [e3007084ca90495cc4e8b9d875938f6d52c8a25c] workaround for bootstrap col-auto max width
* [ad0896a0ab4b28705e9bef122050bf330f557f9b] fix scroll to top (styles)

.. _v1.1.0:

1.1.0 (2018-08-20)
##################

Major rewrite of Igloo ; see Migrating to 1.1 guide.