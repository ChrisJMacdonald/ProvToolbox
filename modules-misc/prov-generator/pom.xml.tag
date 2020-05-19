<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <parent>
    <artifactId>modules-misc</artifactId>
    <groupId>org.openprovenance.prov</groupId>
    <version>0.9.3</version>
  </parent>

  <modelVersion>4.0.0</modelVersion>
  <artifactId>prov-generator</artifactId>
  <name> |---- PROV-GENERATOR</name>
  <packaging>jar</packaging>
  <description>A random generator of PROV graphs.</description>




  <dependencies>
    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-model</artifactId>
      <version>0.9.3</version>
    </dependency>

    <!-- testing -->

    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-xml</artifactId>
      <version>0.9.3</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-n</artifactId>
      <version>0.9.3</version>
      <scope>test</scope>
    </dependency>
 </dependencies>

  <build>

    <resources>
      <resource>
        <directory>src/main/resources</directory>
        <filtering>true</filtering>
      </resource>
    </resources>


    <testResources>
       <testResource>
         <directory>src/test/resources</directory>
         <filtering>true</filtering>
       </testResource>
    </testResources>

    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-javadoc-plugin</artifactId>
        <configuration>
          <source>1.9</source>
        </configuration>
      </plugin>
    </plugins>


  </build>



</project>