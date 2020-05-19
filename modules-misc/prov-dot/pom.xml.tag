<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-misc</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>prov-dot</artifactId>
    <name> |---- PROV-DOT</name>
    <packaging>jar</packaging>
    <description>A conversion of PROV Java Beans into DOT format for visualization.</description>




    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-model</artifactId>
            <version>0.9.3</version>
        </dependency>

        <!-- to load the configuration: FIXME: we should move away from this! -->
        <dependency>
            <groupId>org.glassfish.jaxb</groupId>
            <artifactId>jaxb-runtime</artifactId>
            <version>${jaxb.api.version}</version>
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
            <artifactId>prov-xml</artifactId>
            <version>0.9.3</version>
            <scope>test</scope>
            <classifier>tests</classifier>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-n</artifactId>
            <version>0.9.3</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-n</artifactId>
            <version>0.9.3</version>
            <scope>test</scope>
            <classifier>tests</classifier>
        </dependency>
    </dependencies>

    <build>

        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
            </resource>
        </resources>


        <plugins>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <configuration>
                    <source>1.9</source>
                    <additionalOptions>
                        <additionalOption>-Xdoclint:none</additionalOption>
                    </additionalOptions>
                </configuration>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>2.3.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>test-jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>


        <testResources>
            <testResource>
                <directory>src/test/resources</directory>
                <filtering>true</filtering>
            </testResource>
        </testResources>
    </build>
</project>
