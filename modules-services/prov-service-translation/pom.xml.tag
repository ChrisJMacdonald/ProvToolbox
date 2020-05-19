<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.openprovenance.prov</groupId>
        <artifactId>modules-services</artifactId>
        <version>0.9.3</version>
    </parent>

    <artifactId>prov-service-translation</artifactId>
    <name> |---- PROV-SERVICE-TRANSLATION</name>
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-interop</artifactId>
            <version>0.9.3</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-service-core</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-template</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-generator</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>${servletapi.version}</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>io.swagger.core.v3</groupId>
            <artifactId>swagger-jaxrs2</artifactId>
            <version>${swagger.version}</version>
            <scope>provided</scope>
        </dependency>

        <!-- testing -->
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-xml</artifactId>
            <version>0.9.3</version>
            <scope>test</scope>
        </dependency>

    </dependencies>

    <build>
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
                    <source>9</source>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
