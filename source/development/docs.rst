Documentation modification
==========================

Miscelleaneous
--------------

The documentation is located at http://igloo-doc.readthedocs.io/en/latest/index.html


Contributing to the doc
-----------------------

Install the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^

To edit and update documentation;

.. code-block:: bash

  git clone git@github.com:igloo-project/igloo-doc.git
  cd igloo-doc
  rm -rf .tools
  pipenv install
  pipenv shell


Build the documentation locally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A few commands to interact with the documentation locally:

.. code-block:: bash

  # build documentation
  clickable sphinx build html
  # start a local server and preview documentation in browser (http://localhost:8000)
  clickable sphinx live
  # clean
  clickable sphinx clean

Build the documentation on ReadTheDocs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To modify the online documentation, you just have to push your modifications on
the igloo-doc git repository. A webhook is set and will automatically rebuild
the documentation everytime you push something.
