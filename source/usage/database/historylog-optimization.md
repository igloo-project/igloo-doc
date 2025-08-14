# HistoryLog / HistoryDifference storage optimization

HistoryLog and HistoryDifference tables can grow bigger and bigger over time
if there is no table cleaning policy.

With Igloo 6.14.0, HistoryLog and HistoryDifference storage is optimized to
allow a 50% gain. This optimization switch the columns storing entity types
to a SQL enum column.

40-50% storage gain is expected if HistoryLog stores frequently 3 or 4 objects
references in main / subject / object1 / object2 / object3 / object4 columns.

If you do not have a big history use, or if you don't use these columns, expected
gain will be lower.

Pay attention that this optimization also switch column values from fully
qualified object type (`my.package.my.EntityType`) to simple name object type
(`EntityType`). If you access this columns directly without hibernate mapping
(native query, postgresql functions), you may need to update your native SQL
scripts.

## Summary

Optimization is enabled by default and can be disabled by
`spring.jpa.properties.igloo.historylog.optimization.enabled=false` property.

When enabled:
* Hibernate mapping is updated to use an SQL enum type named
  `historylog_reference_type`.
* Hibernate startup is modified to register a `JdbcSqlType` that knows all
  current Hibernate entity types, so that in can convert an entity simple
  name to / from a java class.
* SqlRunner automatically adds enum type creation or update to the generated
  SQL creation / migration script.

## Implementation

* `HistoryEntityReferenceIntegrator` (triggered by META-INF/services/ and property):
  * register an observer responsible for updating `HistoryEntityReferenceTypeJdbcType`
  * register HistoryEntityReferenceSchemaContributor to adapt SqlRunner behavior
* `HistoryEntityReferenceTypeContributor` (triggered by META-INF/services/ and property):
  * switch between the appropriate `CompositeType` for `HistoryEntityReference`:
    optimzed `HistoryEntityReferenceEnumCompositeType,` or legacy `HistoryEntityReferenceLegacyCompositeType`
  * register a custom `HistoryEntityReferenceDdlType` if needed

(historylog-optimization-migration)=

## Migration

Here are the steps to perform migration on an existing project.

### Always needed

`HistoryEntityReference` and `HistoryValue` types are used both in `HistorySummaryEvent`
and `HistoryLog`/`HistoryDifference`.

The types are split so that modification only affects `HistoryLog`/`HistoryDifference`,
and an interface is added to allow code factorization.
* HistoryValue become `HistoryValue` and `HistoryEventValue` (both are `IHistoryValue`)
* HistoryEntityReference become `HistoryEntityReference` and `HistoryEventEntityReference` (both are
  `IHistoryEntityReference`)

In you project, you must:
* Replace `valueService.create(...` by `valueService.createHistoryValue(...`
  or `valueService.createHistoryEventValue(...`
* Replace `HistoryValue` by `IHistoryValue`
* Rename `HistoryValueRenderer` to `IHistoryValueRenderer` (as it can render both types)

### Option 1: switch to enum type

If you want to use this optimization, you need to upgrade HistoryLog and HistoryDifference
tables so that they uses an SQL enum type.

Run your project's SQL update generation script. The first part of the migration script must
be the enum creation code, populated with the expected entity types (and the automatic cast
rule creation). This code is the first part of your database migration.

Here is an example of the provided script:

```sql
CREATE TYPE historylog_reference_type AS ENUM (
	'Entity1',
  'Entity2',
);
create cast (pg_catalog.varchar as historylog_reference_type) with inout as implicit;
create cast (historylog_reference_type as pg_catalog.varchar) with inout as implicit;
```

The second part of your migration is the appropriate HistoryLog and HistoryDifference
ALTER statements. They need to split fully-qualified entity name to keep only the simple name.

* Check you `HistoryLog` type in your project. Note all the custom HistoryValue fields you
  have added to the default ones (mainObject, subject, object1, object2, object3, object4)
* Add your own field to the following update script:

```sql
-- Work in progress...
```


### Option 2: do not switch to enum type

You may choose to delay or ignore this optimization.

Just add the following property to you project:

```ini
spring.jpa.properties.igloo.historylog.optimization.enabled=false
```
