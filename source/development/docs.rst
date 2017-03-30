Documentation
=============

Miscelleaneous
--------------

The documentation is located at http://owsi-core-doc.readthedocs.io/en/latest/index.html


Contributing to the doc
-----------------------

Install the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^

To install the documentation on your computer, follow these steps :

First clone the git repository owsi-core-doc

.. code-block:: bash

  git@github.com:openwide-java/owsi-core-doc.git

When the clone is over, execute the installation script :

.. code-block:: bash

  cd ~/git/owsi-core-doc
  ./bootstrap.sh

When the script ends, the documentation installation is finished.

Build the documentation locally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A few commands to interact with the documentation locally :

.. code-block:: bash

  invoke docs

The command 'docs' builds the documentation and generates the html files.

.. code-block:: bash

  invoke docs-live

The command 'docs-live' builds the documentation and opens it in a new tab of your browser,
allowing you to see your modifications as soon as you save them.

.. code-block:: bash

  invoke docs-clean

The command 'docs-clean' cleans all the build directory and files.

Build the documentation on ReadTheDocs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To modify the online documentation, you just have to push your modifications on
the owsi-core-doc git repository. A webhook is set and will automatically rebuild
the documentation everytime you push something.
