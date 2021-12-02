Documentation
=============

Miscelleaneous
--------------

The documentation is located at http://igloo-doc.readthedocs.io/en/latest/index.html


Contributing to the doc
-----------------------

Install the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^

To install the documentation on your computer, follow these steps :

First clone the git repository igloo-doc

.. code-block:: bash

  git@github.com:igloo-project/igloo-doc.git

When the clone is over, execute the installation script :

.. code-block:: bash

  cd ~/git/igloo-doc
  rm -rf .tools
  pipenv install
  pipenv shell

When the script ends, the documentation installation is finished.


Build the documentation locally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A few commands to interact with the documentation locally :

.. code-block:: bash

  clickable sphinx build html

This command builds the documentation and generates the html files.

.. code-block:: bash

  clickable sphinx live

This command builds the documentation and opens it in a new tab of your browser,
allowing you to see your modifications as soon as you save them.

.. code-block:: bash

  clickable sphinx clean

This command cleans all the build directory and files.

Build the documentation on ReadTheDocs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To modify the online documentation, you just have to push your modifications on
the igloo-doc git repository. A webhook is set and will automatically rebuild
the documentation everytime you push something.
