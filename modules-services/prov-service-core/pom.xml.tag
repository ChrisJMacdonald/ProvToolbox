<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.openprovenance.prov</groupId>
        <artifactId>modules-services</artifactId>
        <version>0.9.3</version>
    </parent>
    <artifactId>prov-service-core</artifactId>
    <name> |---- PROV-SERVICE-CORE</name>
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
            <artifactId>prov-interop</artifactId>
            <version>0.9.3</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-jsonld-xml</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-log</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-storage-api</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-storage-filesystem</artifactId>
            <version>0.9.3</version>
        </dependency>

        <!-- only used in DocumentMessageBodyWriter, for prov-xml beans. So make it provided! -->
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-xml</artifactId>
            <version>0.9.3</version>
            <scope>provided</scope>
        </dependency>


        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>${servletapi.version}</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>org.jboss.resteasy</groupId>
            <artifactId>resteasy-multipart-provider</artifactId>
            <version>${resteasy.version}</version>
            <exclusions>
                <exclusion>
                    <groupId>org.jboss.spec.javax.xml.bind</groupId>
                    <artifactId>jboss-jaxb-api_2.3_spec</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>com.sun.xml.bind</groupId>
                    <artifactId>jaxb-core</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>com.sun.xml.bind</groupId>
                    <artifactId>jaxb-impl</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>org.quartz-scheduler</groupId>
            <artifactId>quartz</artifactId>
            <version>2.1.6</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>${jackson.version}</version>
            <scope>compile</scope>
        </dependency>

        <dependency>
            <groupId>io.swagger.core.v3</groupId>
            <artifactId>swagger-jaxrs2</artifactId>
            <version>${swagger.version}</version>
            <scope>provided</scope>
        </dependency>

    </dependencies>


    <build>

        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
            </resource>
            <resource>
                <directory>src/main/config</directory>
                <filtering>true</filtering>
                <includes>
                    <include>log4j.xml</include>
                </includes>
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>9</source>
                    <target>9</target>
                </configuration>
            </plugin>
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
