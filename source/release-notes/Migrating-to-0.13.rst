Migrating to 0.13
=================

This guide aims at helping OWSI-Core users migrate an application based on
OWSI-Core 0.12 to OWSI-Core 0.13.

In order to migrate from an older version of OWSI-Core, please refer
to `Migrating to 0.12`_ first.

.. _Migrating to 0.12: Migrating-to-0.12.html

owsi-core version numbering policy
----------------------------------

owsi-core version 0.12.5 is the last version published exclusively for jdk 7. From
owsi-core 0.13, vanilla versions will be built for java 1.8, and jdk 8 dependant
starting owsi-core 0.14.

owsi-core 0.13.0 is planned to be a 0.12.5 isofunctionnal release, but
published both for jdk 7 and 8.

Knowing this, you have two solutions for migrating from 0.12 to 0.13 : migrate
to jdk 8 at the same time or keep a jdk 7 environment.

Solution 1: continue to use jdk 7
---------------------------------

This solution allows you to upgrade project towards post or equals 0.13 release
in a jdk 7 environment.

Please note that this version can be run in a java 8 environment.

.. note::

   If your code base is already upgraded toward jdk7 version, you can switch
   directly to step 3 to upgrade your Eclipse's configuration.


Step 1 · udpate dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Change project parent and owsi-core version to switch to jdk 7 dependency:

.. code-block:: xml

   <parent>
       <groupId>fr.openwide.core.parents</groupId>
       <artifactId>owsi-core-parent-core-project-jdk7</artifactId>
       <version>0.13.jdk7-SNAPSHOT</version>
   </parent>

   [...]

   <properties>
       <owsi-core.version>0.13.jdk7-SNAPSHOT</owsi-core.version>
   </properties>

.. note::

   owsi-core 0.13 codebase and all its upgrades will continue to support the use of
   java 1.7. You just have to add the **.jdk7** modifier after the version. Therefore
   you’ll need to use **0.13.0.jdk7**, **0.13.1.jdk7**...
   owsi-core SNAPSHOT version will be flagged **0.13.jdk7-SNAPSHOT**.


Step 2 · clean your codebase
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Perform a global maven clean so that generated source code is cleaned.

No more steps are needed to enable maven build.


Step 3 (for Eclipse IDE) · install m2e integration and reconfigure m2e-apt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Code generation, configured with maven-processor-plugin, is modified to
facilitate m2e plugin integration. It is now recommended to use jboss m2e
maven-processor-plugin integration.

Plugin intallation's instructions are available here: https://github.com/jbosstools/m2e-apt

It is easily installable via Eclipse Marketplace: m2e-apt (at least from Eclipse
4.5.2)

It is installed by default in Eclipse's team bundles from version 4.6.0

In *Windows → Preferences → Maven → Annotation Processing*, choose
*Experimental: Delegate annotation processing to maven plugins...* (this option
is known to work correctly for our use-cases)

If not done automatically, you need to reconfigure Maven projects (right-click
on parent project, *Maven → Update project... → OK*

.. note::

   Nothing to do with jdk version, but you may need to pay attention to the
   following setting : Windows → Preferences → Team → Git → Projects →
   **Uncheck** Automatically ignore derived resources by adding theme to
   .gitignore ; this setting prevents Eclipse to alter .gitignore configurations


Step 4 · optimization
^^^^^^^^^^^^^^^^^^^^^

If source code generation is to heavy on your project, you can restrain
regeneration on project reconfiguration by adding the following m2e's configuration
in your parent pom.xml (*dependencyManagement* section)

.. code-block:: xml

   <pluginsManagement>
     <plugins>
       <plugin>
         <groupId>org.eclipse.m2e</groupId>
         <artifactId>lifecycle-mapping</artifactId>
         <version>1.0.0</version>
         <configuration>
         	<lifecycleMappingMetadata>
         	  <pluginExecutions>
         	    <pluginExecution>
         	      <pluginExecutionFilter>
         	        <groupId>org.bsc.maven</groupId>
         	        <artifactId>maven-processor-plugin</artifactId>
         	        <versionRange>[0,)</versionRange>
         	        <goals>
         	       	  <goal>process</goal>
         	          <goal>process-test</goal>
         	        </goals>
         	      </pluginExecutionFilter>
         	      <action>
         	      	<execute>
         	      	  <runOnConfiguration>true</runOnConfiguration>
         	      	  <runOnIncremental>false</runOnIncremental>
         	      	</execute>
         	      </action>
         	    </pluginExecution>
         	  </pluginExecutions>
         	</lifecycleMappingMetadata>
         </configuration>
       </plugin>
     </plugins>
   </pluginManagement>


Solution 2 · switch to jdk 8 version
------------------------------------

This version use the same code base than jdk 7 (for 0.13 versions), but use a
jdk 8 runtime. As jdk 7 version is compatible with jdk 8, this version is
mainly provided to prepare your migration to jdk 8.


Step 1 · update dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Simply make sure you use a post or equals 0.13 owsi-core version
(without the .jdk7 modifier).


Step 2 to 4
^^^^^^^^^^^

Follow the same steps 2 to 4 than jdk 7 version.
