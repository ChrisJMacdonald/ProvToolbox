<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-legacy</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>prov-rdf</artifactId>
    <name> |---- PROV-RDF</name>
    <packaging>jar</packaging>
    <description>A conversion of PROV java beans into RDF,  generated by elmo plugin from the PROV-OWL ontology.</description>


    <!--
      <repositories>
        <repository>
            <id>aduna-opensource.releases</id>
            <name>Aduna Open Source - Mavenr eleases</name>
            <url>http://repo.aduna-software.org/maven2/releases</url>
        </repository>
      </repositories>

    -->

    <properties>
        <!--    <sesame.version>2.6.10</sesame.version>  -->
        <sesame.version>4.1.2</sesame.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-model</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openrdf.sesame</groupId>
            <artifactId>sesame-runtime</artifactId>
            <version>${sesame.version}</version>
        </dependency>

        <dependency>
            <groupId>org.openrdf.sesame</groupId>
            <artifactId>sesame-rio-n3</artifactId>
            <version>${sesame.version}</version>
        </dependency>

        <dependency>
            <groupId>org.openrdf.sesame</groupId>
            <artifactId>sesame-rio-rdfxml</artifactId>
            <version>${sesame.version}</version>
        </dependency>

        <dependency>
            <groupId>org.openrdf.sesame</groupId>
            <artifactId>sesame-rio-trig</artifactId>
            <version>${sesame.version}</version>
        </dependency>

        <!-- testing -->

        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-nop</artifactId>
            <version>1.7.26</version>
            <scope>test</scope>
        </dependency>

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
            <classifier>tests</classifier>
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



        <plugins>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.1.1</version>
                <configuration>
                    <source>1.9</source>
                </configuration>
            </plugin>

            <!--
                  <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-javadoc-plugin</artifactId>
                    <version>2.3</version>
                  </plugin>
                     <plugin>
                         <groupId>org.apache.maven.plugins</groupId>
                         <artifactId>maven-compiler-plugin</artifactId>
                         <configuration>
                             <source>8</source>
                             <target>8</target>
                         </configuration>
                     </plugin>

            -->
        </plugins>

        <pluginManagement>
            <plugins>
                <plugin>
                    <!--  This plugin's configuration is used to store Eclipse m2e settings
                        only. It has no influence on the Maven build itself. -->
                    <groupId>org.eclipse.m2e</groupId>
                    <artifactId>lifecycle-mapping</artifactId>
                    <version>1.0.0</version>
                    <configuration>
                        <lifecycleMappingMetadata>
                            <pluginExecutions>
                                <pluginExecution>
                                    <pluginExecutionFilter>
                                        <groupId>org.jvnet.jaxb2.maven2</groupId>
                                        <artifactId>maven-jaxb2-plugin</artifactId>
                                        <versionRange>[0.7.0,)</versionRange>
                                        <goals>
                                            <goal>generate</goal>
                                        </goals>
                                    </pluginExecutionFilter>
                                    <action>
                                        <execute>
                                            <runOnIncremental>false</runOnIncremental>
                                        </execute>
                                    </action>
                                </pluginExecution>

                                <pluginExecution>
                                    <pluginExecutionFilter>
                                        <groupId>org.apache.maven.plugins</groupId>

                                        <artifactId>maven-antrun-plugin</artifactId>
                                        <versionRange>[1.3,)</versionRange>

                                        <goals>
                                            <goal>run</goal>
                                        </goals>
                                    </pluginExecutionFilter>
                                    <action>
                                        <execute>
                                            <runOnIncremental>false</runOnIncremental>
                                        </execute>
                                    </action>
                                </pluginExecution>
                            </pluginExecutions>
                        </lifecycleMappingMetadata>
                    </configuration>
                </plugin>
            </plugins>


        </pluginManagement>


        <testResources>
            <testResource>
                <directory>src/test/resources</directory>
                <filtering>true</filtering>
            </testResource>
        </testResources>
    </build>



</project>
