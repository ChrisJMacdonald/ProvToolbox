<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.openprovenance.prov</groupId>
        <artifactId>modules-storage</artifactId>
        <version>0.9.3</version>
    </parent>
    <artifactId>prov-storage-filesystem</artifactId>
    <name> |---- PROV-STORAGE-FILESYSTEM</name>
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-model</artifactId>
            <version>0.9.3</version>
        </dependency>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-storage-api</artifactId>
            <version>0.9.3</version>
        </dependency>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-interop</artifactId>
            <version>0.9.3</version>
            <scope>provided</scope>
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
            <testResource>
                <directory>src/test/config</directory>
                <filtering>true</filtering>
                <includes>
                    <include>log4j.xml</include>
                </includes>
            </testResource>
        </testResources>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
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


    </build>

</project>