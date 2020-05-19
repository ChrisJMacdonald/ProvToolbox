<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-services</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>service-translator</artifactId>
    <name> |---- SERVICE-TRANSLATOR</name>
    <packaging>war</packaging>
    <description>A REST service for PROV provenance</description>


    <dependencies>


        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-interop-light</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-rdf</artifactId>
            <version>0.9.3</version>
            <exclusions>
                <exclusion>
                    <groupId>org.log4j</groupId>
                    <artifactId>slf4j-api</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.log4j</groupId>
                    <artifactId>slf4j-log4j12</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                    <artifactId>httpcore-osgi</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                    <artifactId>httpclient-osgi</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-service-core</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-service-translation</artifactId>
            <version>0.9.3</version>
            <scope>compile</scope>
        </dependency>


        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-storage-index-redis</artifactId>
            <version>0.9.3</version>
        </dependency>

        <!-- for testing -->


        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-model</artifactId>
            <version>0.9.3</version>
            <classifier>tests</classifier>
            <scope>test</scope>
        </dependency>



        <dependency> <!-- overriding -->
            <groupId>javax.json</groupId>
            <artifactId>javax.json-api</artifactId>
            <version>1.1.2</version>
        </dependency>

        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-nop</artifactId>
            <version>1.7.12</version>
        </dependency>




        <!--

                <dependency>
                    <groupId>org.jboss.resteasy</groupId>
                    <artifactId>resteasy-jaxb-provider</artifactId>
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
        -->

        <dependency>
            <groupId>org.jboss.resteasy</groupId>
            <artifactId>resteasy-servlet-initializer</artifactId>
            <version>${resteasy.version}</version>
            <exclusions>
                <exclusion>
                    <groupId>org.jboss.spec.javax.xml.bind</groupId>
                    <artifactId>jboss-jaxb-api_2.3_spec</artifactId>
                </exclusion>
                <exclusion>
                    <artifactId>activation</artifactId>
                    <groupId>javax.activation</groupId>
                </exclusion>
            </exclusions>

            <!-- required to exclude to run in tomcat7
            <exclusions>
              <exclusion>
            <groupId>javax.el</groupId>
            <artifactId>javax.el-api</artifactId>
              </exclusion>
            </exclusions>
    -->
        </dependency>

        <dependency>
            <groupId>org.jboss.resteasy</groupId>
            <artifactId>resteasy-client</artifactId>
            <version>${resteasy.version}</version>
            <scope>test</scope>

            <exclusions>

                <exclusion>
                    <groupId>org.jboss.spec.javax.xml.bind</groupId>
                    <artifactId>jboss-jaxb-api_2.3_spec</artifactId>
                </exclusion>

                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                    <artifactId>httpcore-osgi</artifactId>
                </exclusion>


                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                    <artifactId>httpcore</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                    <artifactId>httpclient</artifactId>
                </exclusion>

                <exclusion>
                    <artifactId>activation</artifactId>
                    <groupId>javax.activation</groupId>
                </exclusion>

            </exclusions>
        </dependency>

        <!--
            <dependency>
              <groupId>org.apache.httpcomponents</groupId>
              <artifactId>httpcore</artifactId>
              <version>4.4.11</version>
              <scope>test</scope>
          </dependency>
            <dependency>
              <groupId>org.apache.httpcomponents</groupId>
              <artifactId>httpclient</artifactId>
              <version>4.5.9</version>
              <scope>test</scope>
          </dependency>
          -->

        <!-- optional, good for handling I/O task -->
        <dependency>
            <groupId>commons-io</groupId>
            <artifactId>commons-io</artifactId>
            <version>2.5</version>
        </dependency>

        <dependency>
            <groupId>org.quartz-scheduler</groupId>
            <artifactId>quartz</artifactId>
            <version>2.3.0</version>
        </dependency>


        <dependency> <!-- overriding library -->
            <groupId>com.fasterxml.jackson.jaxrs</groupId>
            <artifactId>jackson-jaxrs-json-provider</artifactId>
            <version>${jackson.version}</version>
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
            <exclusions>
                <exclusion>  <!-- using the jboss version instead -->
                    <artifactId>jaxb-api</artifactId>
                    <groupId>javax.xml.bind</groupId>
                </exclusion>
            </exclusions>
        </dependency>


        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>swagger-ui</artifactId>
            <version>${swagger.ui.version}</version>
        </dependency>

        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>jquery</artifactId>
            <version>3.3.1</version> <!-- need to change version in jsp files too -->
        </dependency>

        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>bootstrap-table</artifactId>
            <version>1.9.1</version>
        </dependency>

        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>bootstrap</artifactId>
            <version>3.3.7</version>
        </dependency>

        <dependency>
            <groupId>org.webjars</groupId>
            <artifactId>font-awesome</artifactId>
            <version>4.7.0</version>
        </dependency>

        <dependency>
            <groupId>org.webjars.bowergithub.ajaxorg</groupId>
            <artifactId>ace-builds</artifactId>
            <version>1.4.5</version>
        </dependency>




    </dependencies>




    <build>
        <plugins>

            <plugin>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.2.3</version>
                <configuration>
                    <failOnMissingWebXml>false</failOnMissingWebXml>
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

            <plugin>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.2.0</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>test-jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>


        </plugins>

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
    </build>

    <properties>
        <service.port>7071</service.port>
    </properties>


    <profiles>

        <profile>
            <id>local</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <isdocker />
                <upload.directory>target/</upload.directory>
                <validation.log.location>target/</validation.log.location>
                <validation.prov.log.location>target/</validation.prov.log.location>
                <hsqldb.location>target/test-database/database</hsqldb.location>
            </properties>

            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-failsafe-plugin</artifactId>
                        <version>2.18.1</version>
                        <configuration>
                            <encoding>UTF-8</encoding>
                            <runOrder>alphabetical</runOrder>
                        </configuration>
                        <executions>
                            <execution>
                                <id>integration-test</id>
                                <goals>
                                    <goal>integration-test</goal>
                                </goals>
                            </execution>
                            <execution>
                                <id>verify</id>
                                <goals>
                                    <goal>verify</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>

        <profile>
            <id>docker</id>
            <properties>
                <isdocker>docker</isdocker>
                <upload.directory>/home/pservice/files/</upload.directory>
                <validation.log.location>/home/pservice/log/</validation.log.location>
                <validation.prov.log.location>/home/pservice/log/</validation.prov.log.location>
                <hsqldb.location>target/test-database/database</hsqldb.location>
            </properties>
            <build>

                <plugins>
                    <plugin>
                        <artifactId>maven-surefire-plugin</artifactId>
                        <version>2.19.1</version>
                        <configuration>
                            <skip>true</skip>
                        </configuration>
                    </plugin>
                    <plugin>
                        <artifactId>maven-war-plugin</artifactId>
                        <version>3.2.3</version>
                        <configuration>
                            <failOnMissingWebXml>false</failOnMissingWebXml>
                            <classifier>docker</classifier>
                        </configuration>
                    </plugin>
                    <!--<plugin>
                        <artifactId>maven-jar-plugin</artifactId>
                        <configuration>
                            <classifier>docker</classifier>
                        </configuration>
                    </plugin> -->
                </plugins>
            </build>
        </profile>

        <profile>
            <id>mac</id>
            <properties>
                <isdocker>mac</isdocker>
                <upload.directory>/Users/luc/docker/log-dir/</upload.directory>
                <validation.log.location>/Users/luc/docker/log-dir/log/</validation.log.location>
                <validation.prov.log.location>/Users/luc/docker/log-dir/log/</validation.prov.log.location>
                <hsqldb.location>target/test-database/database</hsqldb.location>
            </properties>
            <build>

                <plugins>
                    <plugin>
                        <artifactId>maven-surefire-plugin</artifactId>
                        <configuration>
                            <skip>false</skip>
                        </configuration>
                    </plugin>
                    <plugin>
                        <artifactId>maven-war-plugin</artifactId>
                        <version>3.2.3</version>
                        <configuration>
                            <failOnMissingWebXml>false</failOnMissingWebXml>
                            <classifier>mac</classifier>
                        </configuration>
                    </plugin>
                    <!--<plugin>
                        <artifactId>maven-jar-plugin</artifactId>
                        <configuration>
                        <classifier>docker</classifier>
                        </configuration>
                        </plugin> -->
                </plugins>
            </build>
        </profile>

        <profile>
            <id>jetty</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <dependencies>
                <dependency>
                    <groupId>org.eclipse.jetty</groupId>
                    <artifactId>jetty-util</artifactId>
                    <version>${jetty.version}</version>
                </dependency>
            </dependencies>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.eclipse.jetty</groupId>
                        <artifactId>jetty-maven-plugin</artifactId>
                        <version>${jetty.version}</version>
                        <configuration>
                            <httpConnector>
                                <!--host>localhost</host-->
                                <port>${service.port}</port>
                            </httpConnector>
                            <!--<scanIntervalSeconds>10</scanIntervalSeconds> -->
                            <stopKey>foo</stopKey>
                            <stopPort>9999</stopPort>
                        </configuration>
                        <executions>
                            <execution>
                                <id>start-jetty</id>
                                <phase>pre-integration-test</phase>
                                <goals>
                                    <goal>start</goal>
                                </goals>
                                <configuration>
                                    <scanIntervalSeconds>0</scanIntervalSeconds>
                                   <!-- <daemon>true</daemon>-->
                                </configuration>
                            </execution>
                            <execution>
                                <id>stop-jetty</id>
                                <phase>post-integration-test</phase>
                                <goals>
                                    <goal>stop</goal>
                                </goals>
                            </execution>
                        </executions>

                        <!--
                        <dependencies>
                              <dependency>
                        <groupId>org.eclipse.jetty</groupId>
                        <artifactId>jetty-util</artifactId>
                        <version>${jetty.version}</version>
                          </dependency>

                          <dependency>
                        <groupId>org.eclipse.jetty</groupId>
                        <artifactId>jetty-jsp</artifactId>
                        <version>${jetty.version}</version>
                          </dependency>
                        </dependencies>
                          -->
                    </plugin>
                </plugins>
            </build>
        </profile>


        <profile>
            <id>tomcat</id>
            <build>
                <plugins>
                    <plugin>

                        <groupId>org.apache.tomcat.maven</groupId>
                        <artifactId>tomcat7-maven-plugin</artifactId>
                        <version>2.2</version>
                        <configuration>
                            <server>local.tomcat</server> <!-- see .m2/settings.xml -->
                            <port>${service.port}</port>
                            <path>/</path>
                        </configuration>
                        <executions>
                            <execution>
                                <id>start-tomcat</id>
                                <phase>pre-integration-test</phase>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                                <configuration>
                                    <fork>true</fork>
                                </configuration>
                            </execution>
                            <execution>
                                <id>stop-tomcat</id>
                                <phase>post-integration-test</phase>
                                <goals>
                                    <goal>shutdown</goal>
                                </goals>
                            </execution>
                        </executions>
                        <dependencies>
                            <dependency>
                                <groupId>org.apache.tomcat</groupId>
                                <artifactId>tomcat-el-api</artifactId>
                                <version>8.0.9</version>
                            </dependency>
                        </dependencies>
                    </plugin>
                </plugins>
            </build>
        </profile>

    </profiles>




</project>
