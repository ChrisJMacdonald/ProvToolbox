<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <parent>
    <artifactId>modules-template</artifactId>
    <groupId>org.openprovenance.prov</groupId>
    <version>0.9.3</version>
  </parent>

  <modelVersion>4.0.0</modelVersion>
  <artifactId>prov-template-compiler</artifactId>
  <name> |---- PROV-TEMPLATE-COMPILER</name>
  <packaging>jar</packaging>
  <description>A template system for PROV bundles.</description>


   <properties>
        <jackson.version>2.9.9</jackson.version>
   </properties>


  <dependencies>
    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-model</artifactId>
      <version>0.9.3</version>
    </dependency>

    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-template</artifactId>
      <version>0.9.3</version>
    </dependency>

    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-xml</artifactId>
      <version>0.9.3</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>com.squareup</groupId>
      <artifactId>javapoet</artifactId>
      <version>1.11.1</version>
    </dependency>

    <dependency>
      <groupId>com.google.guava</groupId>
      <artifactId>guava</artifactId>
      <version>19.0</version>
    </dependency>

    <dependency>
      <groupId>org.apache.maven</groupId>
      <artifactId>maven-model</artifactId>
      <version>3.6.1</version>
    </dependency>

    <!-- testing -->

    <dependency>
      <groupId>org.openprovenance.prov</groupId>
      <artifactId>prov-n</artifactId>
      <version>0.9.3</version>
      <scope>test</scope>
    </dependency>



  </dependencies>

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
  </build>



</project>
