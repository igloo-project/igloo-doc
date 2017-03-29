# UI Placeholder and Enclosure

This pages explains how to write Enclosure and Placeholder. Enclosure and
Placeholder are component which are displayed or hidden (at page-generation
level) based on various input variables.

## Conditions and component's visibility

OWSI-Core provides `Condition` base class which provides easy-to-use
transformation of a Condition (that resolves to true or false result on
an *applies* method's call) as an enclosure or placeholder behavior.

Once your `Condition` created, you can generate the following behaviors :

 * thenShow(): behavior that sets `visibilityAllowed` property equal to
condition's result (enclosure-like behavior)
 * thenHide(): behavior that sets `visibilityAllowed` property equal to
negated condition's result (placeholder-like behavior)
 * thenShowInternal(): behavior that sets `visible` property equal to
condition's result
 * thenHideInternal(): behavior that sets `visible` property equal to
negated condition's result

By convention, `visibilityAllowed` setting (thenHide(), thenShow()) must be
preferred for external impact on component visibility (permission,
inter-component dependencies driven by application behaviors).

On the contrary, `visible` setting is used for internal behaviors. For example,
for a table + pager widget, to control the pager's visibility in relation to
result's page number, as this behavior is driven by an internal state of the
component.

To circumvent visibility settings when `visible` and `visibilityAllowed`
properties conflict, use of an intermediate component may be a solution.

## Component's *enabled* property

`thenEnable()` and `thenDisable()` methods are provided to allow `enabled`
property control, based on the same mechanism than visibility control.

## Deprecated patterns

Before `Condition`, the following components and behaviors were provided:

 * `PlaceholderBehavior`, `EnclosureBehavior`: sets `visibilityAllowed`
property (by default) or an alternate property when provided. This behavior can
be replaced by a Condition method call:
   * `.add(new PlaceholderBehavior().component(component))`:
`.add(Condition.componentVisible(component).thenHide())`
   * `.add(new EnclosureBehavior().component(component))`:
`.add(Condition.componentVisible(component).thenShow())`
   * `.add(new PlaceholderBehavior(ComponentBooleanProperty.VISIBLE).component(component))`:
`.add(Condition.componentVisible(component).thenHideInternal())`
   * `.add(new EnclosureBehavior(ComponentBooleanProperty.VISIBLE).component(component))`:
`.add(Condition.componentVisible(component).thenShowInternal())`

When other method than `component()` is used on `...Behavior` object, others
`Condition`'s methods or subclasses can be used to provides the right behavior
(permission(), anyPermission(), role(), isTrue(), isFalse(), predicate(), ...)
