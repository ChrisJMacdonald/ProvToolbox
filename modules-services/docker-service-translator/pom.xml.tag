<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-services</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>docker-service-translator</artifactId>
    <name>|---- DOCKER-SERVICE-TRANSLATOR</name>
    <packaging>jar</packaging>
    <description>A Docker image for the Translator service</description>



    <properties>
        <origin.project>service-translator</origin.project>
        <upload.directory>/home/pservice/files</upload.directory>  <!-- same folder as in docker profile in service-translator -->
    </properties>

    <build>

        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
            </resource>
        </resources>



        <plugins>

            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>1.6.0</version>
                <executions>
                    <execution>
                        <id>exec1</id>
                        <phase>compile</phase>
                        <goals><goal>exec</goal></goals>
                        <configuration>
                            <workingDirectory>${project.build.directory}</workingDirectory>
                            <executable>make</executable>
                            <arguments>
                                <argument>-f</argument>
                                <argument>classes/Makefile</argument>
                                <argument>build.all</argument>
                            </arguments>
                        </configuration>
                    </execution>
                </executions>
            </plugin>


            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>2.18.1</version>
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




        <pluginManagement>
            <plugins>
                <plugin>
                    <artifactId>maven-antrun-plugin</artifactId>
                    <version>1.7</version>
                    <dependencies>
                        <dependency>
                            <groupId>ant-contrib</groupId>
                            <artifactId>ant-contrib</artifactId>
                            <version>1.0b3</version>
                            <exclusions>
                                <exclusion>
                                    <groupId>ant</groupId>
                                    <artifactId>ant</artifactId>
                                </exclusion>
                            </exclusions>
                        </dependency>
                        <dependency>
                            <groupId>org.apache.ant</groupId>
                            <artifactId>ant-nodeps</artifactId>
                            <version>1.8.1</version>
                        </dependency>
                    </dependencies>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
