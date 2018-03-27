Misc cleaning
=============

Parameter
---------

* Remove old deprecated fields from ``Parameter`` entity, and everything
  related such as service methods. Use ``PropertyId`` and ``PropertyService``
  from now on.
* Remove ``org.iglooproject.spring.config.AbstractConfigurer.java``.
  Use ``PropertyService`` instead.
* Remove ``org.iglooproject.spring.config.CoreConfigurer.java``.
  Use ``PropertyService`` instead.

Old table factory
-----------------

* Remove ``org.iglooproject.wicket.more.markup.html.list.AbstractGenericItemListActionButtons.java``
* Remove ``org.iglooproject.wicket.more.markup.html.list.AbstractGenericItemListPanel.java``
* Remove ``org.iglooproject.wicket.more.markup.html.list.GenericEntityListItemModel.java``
* Remove ``org.iglooproject.wicket.more.markup.html.list.GenericPortfolioPanel.java``
* Remove ``org.iglooproject.wicket.more.markup.html.list.PageablePortfolioPanel.java``
* Remove ``org.iglooproject.wicket.more.markup.html.list.AbstractGenericItemListActionButtons_bs3.html``
* Remove ``org.iglooproject.wicket.more.markup.html.list.AbstractGenericItemListActionButtons.html``
* Remove ``org.iglooproject.wicket.more.markup.html.list.AbstractGenericItemListPanel.html``
* Remove ``org.iglooproject.wicket.more.markup.html.list.GenericPortfolioPanel_bs3.html``
* Remove ``org.iglooproject.wicket.more.markup.html.list.GenericPortfolioPanel.html``
* Remove ``org.iglooproject.wicket.more.markup.html.list.PageablePortfolioPanel.html``

Use ``DataTableBuilder`` or make a custom tables from scratch.

Hibernate JPA
-------------

* Deprecated custom analyzer ``HibernateSearchAnalyzer.TEXT_SORT``.
  Use Hibernate Search ``Normalizer`` instead,
  see ``HibernateSearchNormalizer.TEXT``. For example:

.. code-block:: java

  // Before
  @Field(
    name = FIELD_NAME,
    analyzer = @Analyzer(definition = HibernateSearchAnalyzer.TEXT_SORT)
  )

  // Now
  @Field(
    name = FIELD_NAME,
    normalizer = @Normalizer(definition = HibernateSearchNormalizer.TEXT)
  )

|

* Rename ``GenericUser.USER_NAME_SORT_FIELD_NAME`` to ``GenericUser.USERNAME_SORT``.
* Rename ``GenericSimpleUser.FIRST_NAME_SORT_FIELD_NAME`` to ``GenericSimpleUser.FIRST_NAME_SORT``.
* Rename ``GenericSimpleUser.LAST_NAME_SORT_FIELD_NAME`` to ``GenericSimpleUser.LAST_NAME_SORT``.
* Rename ``QueuedTaskHolder.NAME_SORT_FIELD_NAME`` to ``QueuedTaskHolder.NAME_SORT``.

|

* Remove ``SortNull`` from ``ISort``. Use ``NullSortValue`` instead.
* Remove ``SortUtils#luceneStringSortField(ISort<SortField>, SortOrder, String, SortNull)``.
  Use ``SortUtils#luceneStringSortField(ISort, SortOrder, String, NullSortValue)`` instead.

|

* Remove ``GenericEntityReference#getEntityClass()``.
  Use ``GenericEntityReference#getType()`` instead.
* Remove ``GenericEntityReference#getEntityId()``.
  Use ``GenericEntityReference#getId()`` instead.

|

* Remove ``org.iglooproject.jpa.hibernate.usertype.AbstractMaterializedStringValue.java``.
  Use ``AbstractMaterializedPrimitiveValue instead``.

|

* Remove ``IGenericEntityDao#getEnti.wicket.more.markup.repeater.dataty(Class, K)``.
  Use ``IGenericEntityDao#getById(Class, Serializable)`` instead.
* Remove ``IGenericEntityService#getEntity(Class, K)``.
  Use ``IGenericEntityService#getById(Class, Serializable)`` instead.
* Update ``IGenericEntityService#save(E)`` not public anymore.
  Use specific method if you want to save entities without going through
  ``createEntity`` method.

|

* Remove old criteria query references from ``JpaDaoSupport``.
  Use QueryDSL instead.
  - ``buildTypedQuery(CriteriaQuery criteria, Integer limit, Integer offset)``
  - ``filterCriteriaQuery(CriteriaQuery, Expression)``
  - ``rootCriteriaQuery(CriteriaBuilder, CriteriaQuery, Class)``
  - ``getEntityByField(Class, SingularAttribute, V)``
  - ``getEntityByFieldIgnoreCase(Class clazz, SingularAttribute, String)``
  - ``listEntity(Class, Expression, Integer, Integer, Order...)``
  - ``listEntity(Class, Expression)``
  - ``listEntityByField(Class, SingularAttribute, V)``
  - ``countEntityByField(Class, SingularAttribute, V)``
  - ``countEntity(Class, Expression)``
* Remove old query methods from ``IHibernateSearchDao``,
  ``IHibernateSearchService``, ``IGenericUserService``,
  ``IGenericUserGroupService``.
  Implement your own search query instead, either through a custom DAO or
  through ``ISearchQuery<T, S>`` as defined in ``igloo-component-jpa-more``.
  See in particular ``AbstractHibernateSearchSearchQuery<T, S>``.
* Remove ``AbstractHibernateSearchSearchQuery#getAnalyzer()``.
  Use ``AbstractHibernateSearchSearchQuery#getDefaultAnalyzer()`` instead.

|

* Remove ``Expressions2#map(Map, JPQLQuery, Expression, Expression)``.
  Use ``map.putAll(query.transform(GroupBy2.transformer(GroupBy.map(key, value))))`` instead.
* Remove ``Expressions2#mapToTable(JPQLQuery, Expression, Comparator, Expression, Comparator, Expression)``.
  Use ``query.transform(GroupBy2.transformer(GroupBy2.sortedTable(row, column, value, rowComparator, columnComparator)))`` instead.
* Remove ``Expressions2#mapToTable(Table, JPQLQuery, Expression, Expression, Expression)``.
  Use ``table.putAll(query.transform(GroupBy2.transformer(GroupBy2.table(row, column, value))))`` instead.
* Remove ``Expressions2#mapToTable(Table, JPQLQuery, Expression, Expression, Expression)``.
  Use ``table.putAll(query.transform(GroupBy2.transformer(GroupBy2.table(row, column, value))))`` instead.

|

* ``GenericUser.java`` attribute ``userName`` has been renamed to ``username``. The following script should handle this update :

.. literalinclude:: scripts/username-replace.sh
  :language: bash

Import & Export
---------------

* Update ``AbstractExcelTableExport#getLocalizedLabel(String)`` to ``AbstractExcelTableExport#localize(String)``.
* Remove ``AbstractSimpleExcelTableExport#getLocalizedLabel(String)``.
  Use ``AbstractSimpleExcelTableExport#localize(String)`` instead.
* Remove ``AbstractExcelTableExport#addHeadersToSheet(Sheet, int, Map)``.
  Use ``AbstractExcelTableExport#addHeadersToSheet(Sheet, int, Collection)`` instead.
* Remove ``AbstractExcelTableExport#finalizeSheet(Sheet, Map)``.
  Use ``AbstractExcelTableExport#finalizeSheet(Sheet, Collection)`` instead.
* Remove ``AbstractExcelTableExport#finalizeSheet(Sheet, Map, boolean)``.
  Use ``AbstractExcelTableExport#finalizeSheet(Sheet, Collection, boolean)`` instead.
* Remove ``AbstractExcelTableExport#resizeMergedColumns(Sheet, Map)``.
  Use ``AbstractExcelTableExport#resizeMergedColumns(Sheet, Collection)`` instead.
* Remove ``org.iglooproject.imports.table.common.event.SimpleTableImportEventHandler.java``.
  Use ``LoggerTableImportEventHandler`` instead.
* Remove ``TableImportLocation#getSheetName()``.
  Use ``TableImportLocation#getTableName()`` instead.
* Remove ``AbstractTableImportColumnSet#missingValue(String)``.
  Use ``AbstractTableImportColumnSet#error(String, Object...)`` instead.

Notification
------------

* Remove ``INotificationBuilderToState#to(String...)``.
  Use ``INotificationBuilderToState#toAddress(String, String...)`` instead.
* Remove ``INotificationBuilderBuildState#cc(String...)``.
  Use ``INotificationBuilderBuildState#ccAddress(String, String...)`` instead.
* Remove ``INotificationBuilderBuildState#bcc(String...)``.
  Use ``INotificationBuilderBuildState#bccAddress(String, String...)`` instead.
* Remove ``INotificationBuilderBuildState#subject(String, String)``.
  Use ``INotificationBuilderBuildState#subjectPrefix(String)``
  and then ``INotificationBuilderBuildState#subject(String)`` instead.
* Remove ``INotificationBuilderSendState#htmlBody(String)``.
  Use ``INotificationBuilderBuildState#content(INotificationContentDescriptor)`` instead.
* Remove ``INotificationBuilderSendState#htmlBody(String, Locale)``.
  Use ``INotificationBuilderBuildState#content(INotificationContentDescriptor)`` instead.

Security
--------

* Remove ``org.iglooproject.jpa.security.service.IGenericEntityPermissionEvaluator.java``.
  Use ``IGenericPermissionEvaluator`` instead.

Lambda and functional
---------------------

* Remove ``org.iglooproject.commons.util.functional.SerializablePredicate``.
	Use ``org.iglooproject.functional.SerializablePredicate2`` instead.
* Remove ``org.iglooproject.commons.util.functional.SerializableFunction``.
	Use ``org.iglooproject.functional.SerializableFunction2`` instead.
* Remove ``org.iglooproject.commons.util.functional.SerializableSupplier``.
	Use ``org.iglooproject.functional.SerializableSupplier2`` instead.
* Remove ``org.iglooproject.commons.util.functional.AbstractSerializablePredicate.java``.
  Use ``SerializablePredicate2`` instead.
* Remove ``org.iglooproject.wicket.more.util.functional.AbstractDetachablePredicate.java``.
  Use ``Condition`` instead.
* Remove ``org.iglooproject.wicket.more.util.functional.DetachablePredicate.java``.
  Use ``Condition`` instead.
* Remove ``Suppliers2#constant(T)``.
  Use ``Suppliers2.ofInstance(T)`` instead.

Properties resources keys
-------------------------

* Change ``console.signIn.button`` to ``console.signIn.action.signIn``
* Change ``console.authentication.originalAuthentication.help`` to ``authentication.originalAuthentication.help``
* Change ``signIn.button`` to ``signIn.action.signIn``
* Change ``common.propertyId.actions.edit`` to ``common.propertyId.action.edit``
* Change ``common.propertyId.actions.edit.title`` to ``common.propertyId.action.edit.title``
* Change ``common.propertyId.actions.edit.success`` to ``common.propertyId.action.edit.success``
* Change ``common.deleteConfirmation`` to ``common.action.delete.confirm.content``
* Change ``common.deleteConfirmation.object`` to ``common.action.delete.confirm.content.object``
* change ``common.confirmTitle`` to ``common.action.confirm.title``
* Change ``common.save`` to ``common.action.save``
* Change ``common.confirm`` to ``common.action.confirm``
* Change ``common.applyFilters`` to ``common.action.filter``
* Change ``common.emptyList`` to ``common.list.empty``
* Change ``common.emptyField`` to ``common.field.empty``

|

* Remove ``common.item.tableRow.edit``
* Remove ``common.item.tableRow.delete``
* Remove ``common.item.tableRow.cancel``
* Remove ``common.item.tableRow.save``
* Remove ``common.item.tableRow.add``
* Remove ``common.portfolio.action.viewDetails``
* Remove ``common.itemList.action.edit``
* Remove ``common.itemList.action.delete``
* Remove ``common.editPopup.title``
* Remove ``common.deletedItem``
* Remove ``common.delete.success``
* Remove ``common.delete.error``
* Remove ``common.logout.tooltip``
