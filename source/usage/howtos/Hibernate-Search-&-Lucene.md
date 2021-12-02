
(hibernate-search)=
# Hibernate Search & Lucene (TODO)

TODO:
 * Base
 * Explain how we should deal with @IndexedEmbedded/@ContainedIn
 * Explain how we should deal with sorts

## Sorting

Sorting behavior depends on the data type:
* to sort by `id`, you have to use the field `GenericEntity.ID_SORT`
* to sort by string, you should define an additional field with the `TEXT_SORT` analyzer:
```java
	@Column
	@Fields({
		@Field(analyzer = @Analyzer(definition = HibernateSearchAnalyzer.TEXT_STEMMING)),
		@Field(name = EN_SORT, analyzer = @Analyzer(definition = HibernateSearchAnalyzer.TEXT_SORT))
	})
	@SortableField(forField = EN_SORT)
	private String en;
```
* to sort by date, you don't need an additional field *BUT* you need to sort using `SortField.Type.LONG` (starting from 0.11)

Note that, you need to add a `@SortableField(forField = "fieldName")` annotation for each field used for sorting.
