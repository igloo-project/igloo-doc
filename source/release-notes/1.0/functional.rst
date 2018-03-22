Functional / lambda
-------------------

This new version enforces the use of
``Serializable{Predicate,Function,Supplier}2``
classes where we previously use ``Serializable*`` variants. This is also
enforced in our custom wicket components methods.

The purpose of this move is :

* To explicitly state in codebase the ``Serializable`` constraint when it is
  needed by wicket page persistence model.

* To build types that enable both guava, java.util and Serializable contracts
  and so that they can be used easily with all these API.

* To implement once and consistently all the needed composition methods
  (for ``SerializablePredicate2``, it is needed to override ``and()``, ``or()``,
  ... to enforce Serializable contract on generated Predicate).

To ease the transition, the following mechanisms can be used:

* This script allow to track all package/class renaming involved.

  .. literalinclude:: scripts/functional-replace.sh
     :language: bash

* For ``@FunctionalInterface`` s, dynamic casting allow to obtain the new types.
  (beware that lambda must involve only ``Serializable`` objects).

* Helpers in ``{Predicate,Function,Supplier}s2`` allow to transform existing
  objects to the targetted type.

For an already working codebase, your ``{Predicate,Function,Supplier}`` used
by wicket are surely ``Serializable``, even if not explicitly enforced by
type declaration, so it is safe to use provided helpers to wrap them to a
``{Predicate,Function,Supplier}2`` instance.
