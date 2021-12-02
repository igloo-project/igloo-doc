(ui-user-actions)=
# UI User Actions (TODO)

TODO:
 * request type (Ajax/non ajax)
 * button appearance (bootstrap button with or without label, non-bootstrap button, ...)
 * button position (in a form, outside a form, in a table, ...)
 * data (submits a form or not)
 * redirections (or not)

## HTML Markup

The following guidelines should be followed every time you add a button to a page:

 * if a click on your button launches javascript code, then use `<button type="button">`. This goes even if your button is outside of a form. This includes buttons triggering an ajax call (`AjaxLink`, `AjaxSubmitLink`, `AjaxButton`) as well as buttons triggering your own javascript.
 * if a click on your button submits a form without using ajax, then use `<button type="submit">`.
 * if a click on your button simply redirects to a bookmarkable page, then it is an actual HTTP link and you should use `<a>`.

The reason for these guidelines is that, while Wicket does support binding ajax calls to `<a>` (or even to arbitrary markup), Wicket does not, however, prevent the default event handler for this markup to execute when a user clicks. Unfortunately, that means that when a user click on a `<a>` with an ajax call bound to the `click` event, then first the ajax call will be performed, then the default action... Which is, for most browser, a scroll to the top of the page. Which probably isn't what you want.
