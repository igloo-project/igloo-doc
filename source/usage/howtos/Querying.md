# Querying

This page explains how to query data using Igloo.

## How to expose queries to the web application

### Through an `ISearchQuery`

#### Use case

`ISearchQuery` should be used when providing a search form to users. It makes it easy to define a search query with numerous search criteria that are independent from each other, the ability to sort the result, and the ability to retrieve the paginated result or the result count.

`ISearchQuery` is also commonly used to implement "autocomplete" queries, i.e. the queries behind Select2 select boxes.

#### Description

`ISearchQuery` is an interface that provides read access to the data while hiding the implementation details, as does a DAO. But on contrary of a DAO:

 * Each interface extending `ISearchQuery` provides one method for each search criterion, which will be kept in memory until data retrieval (`list`, `count`). Note that this "keeping in memory" might not be done explicitly by implementors, but just by starting the query building with the query framework under the hood.
 * For this reason, an `ISearchQuery` instance is stateful and can only be used for **one** query (i.e. search criteria may be added, but not removed nor cleared).
 * `ISearchQuery`s are expected to be used directly from the UI layer

Here is an example of `ISearchQuery`-extending interface:

```java
public interface IPersonSearchQuery extends ISearchQuery<Person, PersonSort> {

	IPersonSearchQuery quickSearch(String filter);

	IPersonSearchQuery lastName(String lastName);

	IPersonSearchQuery firstName(String firstName);

	IPersonSearchQuery company(Company company);
}
```

And here is an example of use (from inside a Wicket DataProvider):

```java
return createSearchQuery(IPersonSearchQuery.class) // Some Spring magic (beanFactory.getBean(...))
		.lastName(lastNameModel.getObject())
		.firstName(firstNameModel.getObject())
		.company(companyModel.getObject())
		.sort(sortModel.getObject())
		.list(offset, limit)
```

### Through a service

#### Use case

Queries should be exposed to the web application through services (a simple method in a service) when:

 * counting the results is not necessary (within a service, that would involve providing two service methods with the same parameters and implementing them, which is a bit of a pain)
 * **and**
  * paging is not necessary
  * **or** criteria are strongly interrelated (they can't be implemented by separate criteria in the underlying query)
  * **or** the query is really too simple to justify the overhead of creating an interface and an implementation class

Note that in any of these case, `ISearchQuery` *could* still be used. It's just a matter of guessing whether using `ISearchQuery` would help in implementing your query or not (spoiler: it probably does).

Also, know that in the case of complex queries (reporting for instance), a `ISearchQuery` is still (and maybe more) relevant, since you may just store arguments passed to criteria methods in attributes and use those attributes later when asked for the results. This brings the advantage of consistency with little implementation cost.

### Exposing sort selection

Whatever the solution you choose among the two above, you may have to provide clients a way to tune the sorting of retrieved data.

In Igloo, this is generally done by adding a parameter to your query that is a `Map<S, SortOrder>` with `S extends ISort<F>` and with `F` being implementation-dependent. `ISort` will allow the implementor to convert the business-level sort definitions into an internal list of fields on which to sort.

`ISort`s are simple business wrappers. Each `ISort` instance by provides a list of sort "fields" (whose type is implementation-dependent).

The implementations are generally an enum type:

```java
public enum PersonSort implements ISort<SortField> {

	SCORE {
		@Override
		public List<SortField> getSortFields(SortOrder sortOrder) {
			return GenericEntitySort.SCORE.getSortFields(sortOrder);
		}
		@Override
		public SortOrder getDefaultOrder() {
			return GenericEntitySort.SCORE.getDefaultOrder();
		}
	},
	ID {
		@Override
		public List<SortField> getSortFields(SortOrder sortOrder) {
			return GenericEntitySort.ID.getSortFields(sortOrder);
		}
		@Override
		public SortOrder getDefaultOrder() {
			return GenericEntitySort.ID.getDefaultOrder();
		}
	},
	LAST_NAME {
		@Override
		public List<SortField> getSortFields(SortOrder sortOrder) {
			return ImmutableList.of(
					SortUtils.luceneSortField(
							this, sortOrder, SortField.Type.STRING,
							Ressortissant.LAST_NAME_SORT
					)
			);
		}
		@Override
		public SortOrder getDefaultOrder() {
			return SortOrder.ASC;
		}
	},
	FIRST_NAME {
		@Override
		public List<SortField> getSortFields(SortOrder sortOrder) {
			return ImmutableList.of(
					SortUtils.luceneSortField(
							this, sortOrder, SortField.Type.STRING,
							Ressortissant.FIRST_NAME_SORT
					)
			);
		}
		@Override
		public SortOrder getDefaultOrder() {
			return SortOrder.ASC;
		}
	},
	FULL_NAME {
		@Override
		public List<SortField> getSortFields(SortOrder sortOrder) {
			return ImmutableList.of(
					SortUtils.luceneSortField(
							this, sortOrder, SortField.Type.STRING,
							Ressortissant.LAST_NAME_SORT
					),
					SortUtils.luceneSortField(
							this, sortOrder, SortField.Type.STRING,
							Ressortissant.FIRST_NAME_SORT
					)
			);
		}
		@Override
		public SortOrder getDefaultOrder() {
			return SortOrder.ASC;
		}
	};

	@Override
	public abstract List<SortField> getSortFields(SortOrder sortOrder);

	@Override
	public abstract SortOrder getDefaultOrder();

}
```

Note that, on the UI side, an utility exists to easily manage a sort selection: `CompositeSortModel`. See [UI-Models](UI-Models.html) for more information.

## How to implement queries

### Search queries (`ISearchQuery`)

You may always use your own implementation. But in most cases, extending one of the two provided abstract classes is the way to go.

**WARNING:** always think to add `@Scope("prototype")` to your implementation, else you will experience very disturbing concurrent modification issues.

#### `AbstractHibernateSearchSearchQuery`

`AbstractHibernateSearchSearchQuery` provides sensible protected methods that allow you to stack criteria on each call of a criterion method.
For convenience, most of those utility methods have no effect when given `null` parameters. This allow clients to skip null-checks entirely and to call your criteria methods regardless of whether or not the users provided a value for each parameter.

Some full implementations already exist in Igloo (most notably for `org.iglooproject.jpa.more.business.generic.query.ISimpleGenericListItemSearchQuery<T, S>`).

The following assumes that Lucene field have already been defined on your entities. If not, see [Hibernate Search & Lucene](Hibernate-Search-&-Lucene.html).

##### Simple match

```java
	@Override
	public IPersonSearchQuery company(Company company) {
		must(matchIfGiven(Person.COMPANY /* Lucene field name for field "company" */, company));
		return this;
	}
```

##### Presence of a single item in a collection field

```java
	@Override
	public IPersonSearchQuery company(Company company) {
		must(beIncludedIfGiven(Person.COMPANIES /* Lucene field name for field "companies" */, company));
		return this;
	}
```

##### Presence of at least one item from a set in a collection field

```java
	@Override
	public IPersonSearchQuery company(Set<Company> companies) {
		must(matchOneIfGiven(Person.COMPANY /* Lucene field name for field "company" */, companies));
		return this;
	}
```

##### Presence of all items from a set in a collection field

```java
	@Override
	public IPersonSearchQuery companies(Set<Company> companies) {
		must(matchAllIfGiven(Person.COMPANIES /* Lucene field name for field "companies" */, companies));
		return this;
	}
```

##### Range query

```java
	@Override
	public IPersonSearchQuery modificationDate(Date dateMin, Date dateMax) {
		must(matchRange(
				Person.MODIFICATION_DATE,
				dateMin,
				dateMax
		));

		return this;
	}
```

##### "OR" operator

**WARNING:** If you're ORing multiple criterion, the default mechanisms of not applying null criteria may not be enough. You'd better wrap your code in a `if` checking for the presence of arguments.

```java
	@Override
	public IPersonSearchQuery modificationDate(Date dateMin, Date dateMax) {
		if (dateMin != null || dateMax != null) { // BEWARE!
			must(
				any( // = "OR"
					matchRange(
						Person.MODIFICATION_DATE,
						dateMin,
						dateMax
					),
					matchNull(Person.MODIFICATION_DATE)
				)
			);
		}

		return this;
	}
```

##### "AND" operator

If you don't have to nest the "AND" in another "OR", you may simply leverage the fact that criteria are ANDed by default:

```java
	@Override
	public IPersonSearchQuery noDateInfo() {
		// Implicit "AND"
		must(matchNull(Person.MODIFICATION_DATE));
		must(matchNull(Person.CREATION_DATE));

		return this;
	}
```

Otherwise:

```java
	@Override
	public IPersonSearchQuery modificationDate(Date dateMin, Date dateMax) {
		if (dateMin != null || dateMax != null) {
			must(
				any( // = "OR"
					matchRange(
						Person.MODIFICATION_DATE,
						dateMin,
						dateMax
					),
					all( // = "AND"
						matchNull(Person.MODIFICATION_DATE),
						matchNull(Person.CREATION_DATE),
					)
				)
			);
		}

		return this;
	}
```

##### Other criteria

Many more utility methods are provided in `org.iglooproject.jpa.more.business.search.query.AbstractHibernateSearchSearchQuery<T, S>`. If what you're looking for wasn't above, check out the code.

##### Overriding utility methods or extending them
If you feel the need to extend this class with additional utility methods, or to override existing utility methods, know that you may do this simply by overriding `org.iglooproject.jpa.more.config.spring.AbstractJpaMoreJpaConfig.hibernateSearchLuceneQueryFactory()` to return your own query factory.

```java
	@Override
	public IMyHibernateSearchLuceneQueryFactory hibernateSearchLuceneQueryFactory() {
		return new MyHibernateSearchLuceneQueryFactoryImpl();
	}
```

Then in any search query implementation, the utility methods will be those defined in your own query factory. You may access additional methods with this snippet of code:

```java
	@Override
	protected IMyHibernateSearchLuceneQueryFactory getFactory() {
		return (IMyHibernateSearchLuceneQueryFactory) super.getFactory();
	}

	@Override
	public IMySearchQuery label(String label) throws SearchException {
		must(getFactory().myAdditionalUtilityMethod(
				/* ... */
		));
		return this;
	}
```

#### `AbstractJpaSearchQuery`

TODO

### Lower-level solutions (service and DAO methods)

#### JPA querying

TODO QueryDSL-JPA

#### Native SQL querying

TODO QueryDSL-SQL, Hibernate native SQL

#### QueryDSL tips

##### Generating maps and tables

In order to generate a map, use this syntax:

```java
return new JPAQuery<>(getEntityManager())
		.from(QUser.user)
		.groupBy(QUser.user.gender)
		.orderBy(QUser.user.gender.asc())
		.transform(GroupBy2.transformer(GroupBy.sortedMap(QUser.user.gender, QUser.user.count().intValue())));
```

If you need a `com.google.common.collect.Table<R, C, V>` instead of a `Map`, you may use `GroupBy2.table` or `GroupBy2.sortedTable` instead of `GroupBy.sortedMap`.

If the keys in database are too precise, and you want to perform another aggregation on the Java side (for instance turning day-precise dates into weeks), you may use the following syntax:

```java
return new JPAQuery<>(getEntityManager())
		.from(QUser.user)
		.groupBy(QUser.user.gender, QUser.user.creationDate)
		.orderBy(QUser.user.gender.asc(), QUser.user.creationDate.asc())
		.transform(GroupBy2.transformer(GroupBy2.table(
				QUser.user.gender,
				new MappingProjection<Date>(Date.class, QUser.user.creationDate) {
					private static final long serialVersionUID = 1L;
					@Override
					protected Date map(Tuple row) {
						return DateDiscreteDomain.weeks().alignPrevious(row.get(0, Date.class));
					}
				},
				/**
				  * We sum twice: once in the SQL query (for each date) and once in Java (for each week).
				  * We could have summed only in Java, but it would be sub-optimal if
				  * many user are created each day.
				  * The even better solution would have been to group by week in the SQL query,
				  * but unfortunately it's not easy to do with JPQL.
				  */
				GroupBy.sum(QUser.user.count().intValue())
		)));
```

#### Lucene (Hibernate Search) querying

TODO Hibernate Search DSL

TODO [QueryDSL-HibernateSearch](http://www.querydsl.com/static/querydsl/4.1.3/reference/html_single/#hibernate_search_integration)?
