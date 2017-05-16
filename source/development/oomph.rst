Use Oomph with an existing project
=====================================


Files required by Oomph are already in the basic-application repository :

The file /eclipse/tomcat7.launch contains default arguments that will be passed to
your Tomcat server. You will have to modify these arguments/add new arguments here
to make your Tomcat server suit your project.

.. code-block:: xml

   <stringAttribute key="org.eclipse.jdt.launching.VM_ARGUMENTS" value="-Xmx1g -XX:MaxPermSize=256m "/>


The folder /eclipse/tomcat-main contains files that are necessary to Tomcat's
installation and proper working. For a new project, you have to do a modification :
in one of the last lines of the file /eclipse/tomcat-main/server.xml you need to
put the name of your webapp instead of the two mentions to "basicapplication-webapp".


.. code-block:: xml

   <Context docBase="basicapplication-webapp" path="/" reloadable="false" source="org.eclipse.jst.jee.server:basicapplication-webapp"/></Host>
