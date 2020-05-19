<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>ProvToolbox</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <packaging>pom</packaging>
    <name>|&gt;- MODULES: MISC</name>
    <artifactId>modules-misc</artifactId>


    <modules>
        <module>prov-dot</module>
        <module>prov-generator</module>
    </modules>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.1.1</version>
                <configuration>
                    <source>1.8</source>
                </configuration>
            </plugin>
        </plugins>
    </build>


</project>