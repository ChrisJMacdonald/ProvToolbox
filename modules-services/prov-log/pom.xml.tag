<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.openprovenance.prov</groupId>
    <artifactId>modules-services</artifactId>
    <version>0.9.3</version>
  </parent>

  <artifactId>prov-log</artifactId>
  <version>0.9.3</version>
  <name> |---- PROV-LOG</name>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-javadoc-plugin</artifactId>
        <version>3.1.1</version>
        <configuration>
          <source>1.9</source>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
