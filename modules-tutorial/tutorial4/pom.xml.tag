<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <parent>
    <artifactId>modules-tutorial</artifactId>
    <groupId>org.openprovenance.prov</groupId>
    <version>0.9.3</version>
  </parent>

  <modelVersion>4.0.0</modelVersion>
  <artifactId>ProvToolbox-Tutorial4</artifactId>
  <name> |---- ProvToolbox Tutorial 4</name>
  <description>ProvToolbox Tutorial 4</description>

  <developers>
    <developer>
      <id>lucmoreau</id>
      <name>Luc Moreau</name>
      <email>l.moreau@ecs.soton.ac.uk</email>
      <roles>
        <role>Developer</role>
      </roles>
      <organization>University of Southampton</organization>
      <timezone>0</timezone>
    </developer>
    <developer>
      <id>lavm</id>
      <name>Luc Moreau</name>
      <email>lavm@ecs.soton.ac.uk</email>
      <roles>
        <role>Developer</role>
      </roles>
      <organization>University of Southampton</organization>
      <timezone>0</timezone>
    </developer>
  </developers>

  <repositories>
    <!--
        <repository>
          <id>mvn.prov.toolbox</id>
          <name>maven repository for PROV toolbox</name>
          <url>http://openprovenance.org/java/maven-releases/</url>
        </repository>
    -->

    <repository>
      <id>mvn.prov.toolbox.snapshots</id>
      <name>maven snapshot repository for PROV toolbox</name>
      <url>http://openprovenance.org/java/maven-snapshots/</url>
    </repository>
  </repositories>

  <licenses>
    <license>
      <name>MIT License</name>
      <url>license.txt</url>
    </license>
  </licenses>

  <dependencies>
    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-model</artifactId>
      <version>0.9.3</version>
    </dependency>
    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-interop</artifactId>
      <version>0.9.3</version>
    </dependency>
  </dependencies>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-assembly-plugin</artifactId>
        <version>2.2-beta-3</version>
        <!-- there exists a more recent version, but it sets wrong
             permission on directory
             https://jira.codehaus.org/browse/MASSEMBLY-449 -->
        <configuration>
          <descriptors>
            <descriptor>target/classes/assembly.xml</descriptor>
          </descriptors>
        </configuration>
        <executions>
          <execution>
            <phase>package</phase>
            <id>make-assembly</id>
            <goals>
              <goal>single</goal>
            </goals>
          </execution>
        </executions>
      </plugin>


      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-javadoc-plugin</artifactId>
        <version>3.1.1</version>
        <configuration>
          <source>1.9</source>
        </configuration>
      </plugin>
    </plugins>


    <resources>
      <resource>
        <directory>src/main/resources</directory>
        <filtering>true</filtering>
      </resource>
    </resources>

  </build>
</project>
