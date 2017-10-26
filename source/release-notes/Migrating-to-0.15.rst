Migrating to 0.15
=================

This guide aims at helping OWSI-Core users migrate an application based on
OWSI-Core 0.14 to OWSI-Core 0.15.

In order to migrate from an older version of OWSI-Core, please refer
to `Migrating to 0.14`_ first.

.. _Migrating to 0.14: Migrating-to-0.14.html

Mail header
-----------

To migrate from 0.14 to 0.15, you don't need to change a lot of things.
In fact, the only issue you may have is if you send mail to users in your application.

In this case, we have made some changes on the mail header.

You will only have to add a line in your configuration.properties which will inquire the sender :

.. code-block:: text

  notification.mail.sender=my.mail@mail.com
