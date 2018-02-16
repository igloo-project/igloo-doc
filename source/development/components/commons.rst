#######################
igloo-component-commons
#######################

General utilities:

* ICloneable: type-safe generic clone interface

* Implementation of guava ``DiscreteDomain`` for java.time types

* CollectionUtils: helper for collection manipulation (replaceAll, difference,
  intersection). Usefull to update Hibernate bags "in-place" (without
  replacing collection attribute)

* Iterators2: wrap an Iterable to obtain an Iterator. Wrap guava
  Forwarding*Iterator

* ExecutionContext: generic behavior to register task's context (used for
  offline wicket rendering)

* IllegalSwitchValueException: generic exception for bad switch/case value

* FieldPath: abstraction to manipulate tree-ish field names (parent.child.list[], ...)

* Helpers for guava Function behaviors (serializable version, suppliers, ...)

* slf4j bridge handler for java.util.logging as a servlet listener

* Custom MediaType as enum

* Helpers for Comparator et Collator (text normalization before comparison)

* TrueZip: TFileRegistry, used by OpenTFileRegistryFilter

* IRenderer interface

* BatchReport

* @PermissionObject marker to identify security-involved objects

* Basic validators (domain, email, url, telephone number)
