############
Autoprefixer
############

Just like Bootstrap, Igloo uses `Autoprefixer <https://github.com/postcss/autoprefixer>`_
to automatically add vendor prefixes to some CSS properties at build time.
Doing so saves us time and code by allowing us to write key parts of our CSS.

Autoprefixer is enabled by default in our scss build process in deployment mode,
but it's disabled in development mode. This behavior is defined by the property
``autoprefixer.enabled``.

Use ``autoprefixer.enabled=true`` to enable Autoprefixer in a local environment.
