# UI Forms (TODO)

TODO:

 * IndependentNestedForm
 * Available form components
 * How to deal with collections:
  * when only adding/removing is required (no element editing)
  * when only element editing is required (no add/remove)
  * when adding/removing is required **and** element editing is also required
 * ...

## `AutoLabelResolver` and form component / label order

When using `wicket:for` attribut on a `<label/>`, Wicket retrieves related
form component and call `setOutputMarkupId(true)` to create a link between
the label and the form component. However this will not work if the form
component has already been rendered without markup id. This is the case when
the form component comes first in html, e.g.:

```html
<div class="custom-control custom-switch">
  <input type="checkbox" class="custom-control-input" id="customSwitch1">
  <label class="custom-control-label" for="customSwitch1">Toggle this switch element</label>
</div>
```

Workaround: explicit call to `setOutputMarkupId(true)` on form component.
