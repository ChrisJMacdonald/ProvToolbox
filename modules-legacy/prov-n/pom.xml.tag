<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-legacy</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>prov-n</artifactId>
    <name> |---- PROV-N</name>
    <packaging>jar</packaging>
    <description>A Parser for PROV-N Provenance Notation.</description>




    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-model</artifactId>
            <version>0.9.3</version>
        </dependency>
        <dependency>
            <groupId>org.antlr</groupId>
            <artifactId>antlr-runtime</artifactId>
            <version>3.4</version>
        </dependency>
        <dependency>
            <groupId>org.antlr</groupId>
            <artifactId>stringtemplate</artifactId>
            <version>4.0.2</version>
        </dependency>


        <!-- for testing -->
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
                <groupId>org.antlr</groupId>
                <artifactId>antlr3-maven-plugin</artifactId>
                <version>3.5.2</version>

                <executions>

                    <execution>
                        <phase>generate-sources</phase>
                        <goals>
                            <goal>antlr</goal>
                        </goals>
                        <configuration>

                        </configuration>
                    </execution>
                </executions>

            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.1.1</version>
                <configuration>
                    <source>1.8</source>
                </configuration>
            </plugin>


            <!--       <plugin>
                 <groupId>org.antlr</groupId>
                 <artifactId>antlr4-maven-plugin</artifactId>
                 <version>4.5.1</version>

                 <executions>

                       <execution>
                     <phase>generate-sources</phase>
                         <goals>
                           <goal>antlr4</goal>
                         </goals>
                         <configuration>

                         </configuration>
                       </execution>
                 </executions>

                   </plugin>
            -->

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
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>9</source>
                    <target>9</target>
                </configuration>
            </plugin>


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
                                        <groupId>org.antlr</groupId>
                                        <artifactId>antlr3-maven-plugin</artifactId>
                                        <versionRange>[3.4,)</versionRange>
                                        <goals>
                                            <goal>antlr</goal>
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
