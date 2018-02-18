IPropertyService
################

Property registration is modified to allow to use properties during Spring initialization.

Originally introduced to reference some properties during Flyway initialization (flyway
is initialized very early, before hibernate and persistence layer), this modification
allow other components to use IPropertyService lookup before application is fully
initialized.

This modification need to change signature of ``IPropertyRegistryConfig.register``
method.

Method register(IPropertyRegistry propertyRegistry)
---------------------------------------------------

This script allow to quickly refactor your application, if your ``IPropertyRegistryConfig``
classes are named ``*PropertyRegistryConfig.java``.

If not, the modification is to declare ``IPropertyRegistryConfig.register`` **public**.

.. literalinclude:: property-replace.sh
  :language: bash

