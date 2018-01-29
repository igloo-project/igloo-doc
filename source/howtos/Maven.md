# Maven

## JDK level validation

JDK level validation using [Animal sniffer](http://www.mojohaus.org/animal-sniffer/animal-sniffer-maven-plugin/) is enabled by default from Igloo 0.12 on.

If the default JDK version (1.7 at the time of this writing) does not suit you, you should:

 * change the value of the `jdk.version` property to whatever suits you
 * and change the value of the `jdk.signature.artifactId` property to match one of the artifacts found here: http://search.maven.org/#search|ga|1|g%3A%22org.codehaus.mojo.signature%22

If this is somehow impossible and you want to disable these checks completely, you should disable the Animal Sniffer execution with id `check-java-version`.

## Deploy to several servers using the maven-deploy-plugin

```xml
<build>
	<plugins>
		<plugin>
			<groupId>org.codehaus.mojo</groupId>
			<artifactId>wagon-maven-plugin</artifactId>
			<executions>
				<execution>
					<id>upload-war-to-front1</id>
					<phase>deploy</phase>
					<goals>
						<goal>upload-single</goal>
					</goals>
					<configuration>
						<fromFile>${project.build.directory}/${project.artifactId}-${project.version}-${assembly.environment}.tar.gz</fromFile>
						<url>${front1-deployment-url}</url>
					</configuration>
				</execution>
				<execution>
					<id>upload-war-to-front2</id>
					<phase>deploy</phase>
					<goals>
						<goal>upload-single</goal>
					</goals>
					<configuration>
						<fromFile>${project.build.directory}/${project.artifactId}-${project.version}-${assembly.environment}.tar.gz</fromFile>
						<url>${front2-deployment-url}</url>
					</configuration>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>
```
