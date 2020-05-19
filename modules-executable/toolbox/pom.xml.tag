<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <parent>
        <artifactId>modules-executable</artifactId>
        <groupId>org.openprovenance.prov</groupId>
        <version>0.9.3</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    <artifactId>provconvert</artifactId>
    <name> |---- provconvert tool</name>
    <packaging>jar</packaging>
    <description>A tool to manipulate PROV representations from the command line.</description>




    <dependencies>
        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-xml</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-n</artifactId>
            <version>0.9.3</version>
        </dependency>


        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-rdf</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-interop</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-json</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-dot</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-template</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-template-compiler</artifactId>
            <version>0.9.3</version>
        </dependency>

        <dependency>
            <groupId>org.openprovenance.prov</groupId>
            <artifactId>prov-generator</artifactId>
            <version>0.9.3</version>
        </dependency>


        <!-- required by sesame openrdf, to avoid slf4j warning -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-nop</artifactId>
            <version>1.7.26</version>
        </dependency>

        <dependency>
            <groupId>org.codehaus.izpack</groupId>
            <artifactId>izpack-wrapper</artifactId>
            <version>5.1.3</version>
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



        <plugins>


            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.1.1</version>
                <configuration>
                    <source>1.9</source>
                </configuration>
            </plugin>




            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>license-maven-plugin</artifactId>
                <version>1.5</version>
                <executions>
                    <execution>
                        <id>package</id>
                        <goals>
                            <goal>add-third-party</goal>
                        </goals>
                        <configuration>
                            <useMissingFile>true</useMissingFile>
                            <!--<sortArtifactByName>true</sortArtifactByName> -->
                            <licenseMerges>
                                <licenseMerge>Apache 2.0 License|Apache License version 2.0|Apache License, Version 2.0|The Apache Software License, Version 2.0|Apache License|Apache Public License 2.0|Apache 2|Apache 2.0|Apache License 2.0</licenseMerge>
                                <licenseMerge>CDDL|CDDL License|Common Development and Distribution License</licenseMerge>
                                <licenseMerge>BSD License|BSD licence|The BSD License|BSD|Aduna BSD license|BSD-like|BSD-Style License</licenseMerge>
                                <licenseMerge>MIT License|MIT</licenseMerge>
                                <licenseMerge>LGPL|GNU Lesser General Public License|GNU LESSER GENERAL PUBLIC LICENSE</licenseMerge>
                                <licenseMerge>GPLv2+CE|GNU General Public License, Version 2 with the Classpath Exception|GPL2 w/ CPE</licenseMerge>
                            </licenseMerges>
                        </configuration>
                    </execution>
                </executions>
            </plugin>



            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>appassembler-maven-plugin</artifactId>
                <configuration>
                    <programs>
                        <program>
                            <mainClass>org.openprovenance.prov.interop.CommandLineArguments</mainClass>
                            <name>provconvert</name>
                        </program>

                    </programs>
                    <repositoryLayout>default</repositoryLayout>
                    <repositoryName>repo</repositoryName>
                    <platforms>
                        <platform>windows</platform>
                        <platform>unix</platform>
                    </platforms>

                </configuration>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <id>assemble</id>
                        <goals>
                            <goal>assemble</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>


            <plugin>
                <artifactId>maven-antrun-plugin</artifactId>
                <executions>

                    <execution>
                        <id>create.provconvert.1</id>
                        <phase>package</phase>
                        <goals>
                            <goal>run</goal>
                        </goals>
                        <configuration>
                            <tasks>
                                <!-- patch the shell script to avoid changing current directory, so that
                                     relative files are understood as relative to the current directory. -->

                                <exec executable="sed" dir="${project.build.directory}/appassembler/bin">
                                    <arg value="-e s/^cd/#### no CD ### Luc/" />
                                    <arg value="-iBAK" />
                                    <arg value="provconvert" />
                                </exec>

                                <exec executable="sed" dir="${project.build.directory}/appassembler/bin">
                                    <arg value="-e s/exit 1/#### no exit ### Luc/" />
                                    <arg value="-iBAK" />
                                    <arg value="provconvert" />
                                </exec>


                                <exec executable="chmod" dir="${project.build.directory}/appassembler/bin">
                                    <arg value="a+x" />
                                    <arg value="provconvert" />
                                    <arg value="provconvert.bat" />
                                </exec>

                                <!-- man page generation -->

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1">
                                    <arg value=".\&quot; Manpage for provconvert." />
                                </exec>


                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value=".TH man 1 &quot;${maven.build.timestamp}&quot; &quot;${project.version}&quot; &quot;provconvert man page&quot;" />
                                </exec>



                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value=".SH NAME" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value="provconvert \- converts PROV representations" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value=".SH SYNOPSIS" />
                                </exec>

                                <exec executable="${project.build.directory}/appassembler/bin/provconvert" dir="${project.build.directory}/appassembler/bin" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value="-help" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value=".SH BUGS" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value="See https://github.com/lucmoreau/ProvToolbox/issues" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value=".SH AUTHOR" />
                                </exec>

                                <exec executable="echo" dir="${project.build.directory}" output="${project.build.directory}/provconvert.1" append="true">
                                    <arg value="Luc Moreau" />
                                </exec>

                                <exec executable="man" dir="${project.build.directory}" output="${project.build.directory}/provconvert.txt" append="true">
                                    <arg value="${project.build.directory}/provconvert.1" />
                                </exec>

                            </tasks>
                        </configuration>
                    </execution>
                    <execution>
                        <id>create-staging-area</id>
                        <phase>package</phase>
                        <goals>
                            <goal>run</goal>
                        </goals>
                        <configuration>
                            <tasks>
                                <!--<copy todir="${izpack.staging}">
                                          <fileset dir="${basedir}/src/izpack" />
                                </copy>
                                -->
                                <copy file="${basedir}/../../license.txt" tofile="${izpack.staging}/license.txt">
                                </copy>
                                <copy file="${project.build.directory}/provconvert.txt" tofile="${izpack.staging}/Readme.txt">
                                </copy>
                                <copy todir="${izpack.staging}">
                                    <fileset dir="${project.build.directory}/appassembler" />
                                </copy>
                            </tasks>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <configuration>
                    <descriptors>
                        <descriptor>target/classes/toolbox-assembly.xml</descriptor>
                    </descriptors>
                </configuration>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <id>make-assembly</id>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-dependency-plugin</artifactId>
                <executions>
                    <execution>
                        <id>unpack-shared-resources-app</id>
                        <goals>
                            <goal>unpack-dependencies</goal>
                        </goals>
                        <phase>generate-sources</phase>
                        <configuration>
                            <includeGroupIds>org.codehaus.izpack</includeGroupIds>
                            <includeArtifacIds>izpack-wrapper</includeArtifacIds>
                            <excludeTransitive>true</excludeTransitive>
                            <outputDirectory>target/staging</outputDirectory>
                        </configuration>
                    </execution>
                    <execution>
                        <id>unpack-shared-resources-exe</id>
                        <goals>
                            <goal>unpack-dependencies</goal>
                        </goals>
                        <phase>generate-sources</phase>
                        <configuration>
                            <includeGroupIds>org.codehaus.izpack</includeGroupIds>
                            <includeArtifacIds>izpack-wrapper</includeArtifacIds>
                            <classifier>izpack2exe</classifier>
                            <type>zip</type>
                            <excludeTransitive>true</excludeTransitive>
                            <outputDirectory>target/staging</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <artifactId>maven-resources-plugin</artifactId>
                <version>2.7</version>
                <executions>
                    <execution>
                        <id>copy-resources</id>
                        <!-- here the phase you need -->
                        <phase>package</phase>
                        <goals>
                            <goal>copy-resources</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>target/staging</outputDirectory>
                            <resources>
                                <resource>
                                    <directory>${basedir}/src/izpack</directory>
                                    <filtering>true</filtering>
                                </resource>
                            </resources>
                            <filters>
                                <filter>${basedir}/../../modules-core/prov-model/target/classes/org/openprovenance/prov/configuration/config.properties</filter>
                            </filters>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <plugin>
                <groupId>org.codehaus.izpack</groupId>
                <artifactId>izpack-maven-plugin</artifactId>
                <version>${izpack.version}</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals><goal>izpack</goal></goals>
                        <configuration>
                            <!-- base for relative paths in izpack descriptor -->
                            <baseDir>${izpack.staging}</baseDir>
                            <finalName>${project.build.finalName}-Installer</finalName>
                            <installFile>${basedir}/src/izpack/install.xml</installFile>
                        </configuration>
                    </execution>
                </executions>
                <dependencies>
                    <dependency>
                        <groupId>org.codehaus.izpack</groupId>
                        <artifactId>izpack-panel</artifactId>
                        <version>${izpack.version}</version>
                    </dependency>
                </dependencies>
            </plugin>




        </plugins>

        <pluginManagement>
            <plugins>

<!--                <plugin>
                    <groupId>org.eclipse.m2e</groupId>
                    <artifactId>lifecycle-mapping</artifactId>
                    <version>1.0.0</version>
                    <configuration>
                        <lifecycleMappingMetadata>
                            <pluginExecutions>
                                <pluginExecution>
                                    <pluginExecutionFilter>
                                        <groupId>org.codehaus.mojo</groupId>
                                        <artifactId>license-maven-plugin</artifactId>
                                        <versionRange>1.5</versionRange>
                                        <goals>
                                            <goal>add-third-party</goal>
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
                                        <artifactId>maven-dependency-plugin</artifactId>
                                        <versionRange>2.8</versionRange>
                                        <goals>
                                            <goal>unpack-dependencies</goal>
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


-->
            </plugins>


        </pluginManagement>


        <testResources>
            <testResource>
                <directory>src/test/resources</directory>
                <filtering>true</filtering>
            </testResource>
        </testResources>
    </build>

    <properties>
        <izpack.staging>${project.build.directory}/staging</izpack.staging>
        <izpack.version>5.0.3</izpack.version>

        <maven.build.timestamp.format>yyyy-MM-dd HH:mm</maven.build.timestamp.format>
    </properties>



    <profiles>
        <profile>
            <id>izpack-exe-unix</id>
            <activation>
                <activeByDefault>false</activeByDefault>
                <os>
                    <family>unix</family>
                </os>
            </activation>
            <build>
                <plugins>




                </plugins>
            </build>
        </profile>


        <profile>
            <id>linux-only</id>
            <activation>
                <os>
                    <family>linux</family>
                </os>
            </activation>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-antrun-plugin</artifactId>
                        <executions>

                            <execution>
                                <id>IzPack-Mac-Executable-From-LINUX</id>
                                <phase>install</phase>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                                <configuration>
                                    <tasks>
                                        <exec executable="touch" dir="${izpack.staging}/utils/wrappers/izpack2app/">
                                            <arg value="Mac-App-Template" />
                                        </exec>

                                        <exec executable="python" dir="${project.build.directory}">
                                            <arg value="${izpack.staging}/utils/wrappers/izpack2app/izpack2app.py" />
                                            <arg value="${project.build.finalName}-Installer.jar" />
                                            <arg value="${project.build.finalName}-Installer.app" />
                                        </exec>

                                        <exec executable="chmod" dir="${project.build.directory}/${project.build.finalName}-Installer.app/Contents/MacOS">
                                            <arg value="a+x" />
                                            <arg value="universalJavaApplicationStub" />
                                        </exec>

                                        <exec executable="mkdir" dir="${project.build.directory}">
                                            <arg value="dmgdir" />
                                        </exec>
                                        <exec executable="mkdir" dir="${project.build.directory}/dmgdir">
                                            <arg value="${project.build.finalName}-Installer.app" />
                                        </exec>

                                        <copy todir="${project.build.directory}/dmgdir/${project.build.finalName}-Installer.app">
                                            <fileset dir="${project.build.directory}/${project.build.finalName}-Installer.app" />
                                        </copy>

                                        <exec executable="chmod" dir="${project.build.directory}/dmgdir/${project.build.finalName}-Installer.app/Contents/MacOS">
                                            <arg value="a+x" />
                                            <arg value="universalJavaApplicationStub" />
                                        </exec>

                                        <exec executable="echo" dir="${project.build.directory}/dmgdir" output="${project.build.directory}/dmgdir/README.txt">
                                            <arg value="Please run installer to install provconvert." />
                                            <arg value="Make sure you can install applications from anywhere: see http://osxdaily.com/2016/09/27/allow-apps-from-anywhere-macos-gatekeeper/" />
                                        </exec>


                                        <exec executable="genisoimage" dir="${project.build.directory}">
                                            <arg value="-V" />
                                            <arg value="provconvert" />
                                            <arg value="-D" />
                                            <arg value="-R" />
                                            <arg value="-apple" />
                                            <arg value="-no-pad" />
                                            <arg value="-o" />
                                            <arg value="${project.build.finalName}.dmg" />
                                            <arg value="dmgdir" />
                                        </exec>


                                    </tasks>
                                </configuration>
                            </execution>



                            <execution>
                                <id>IzPack-Win-Executable-From-Linux</id>
                                <phase>install</phase>
                                <configuration>
                                    <tasks>
                                        <exec executable="chmod" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="a+x" />
                                            <arg value="7za" />
                                        </exec>

                                        <exec executable="chmod" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="a+x" />
                                            <arg value="upx" />
                                        </exec>


                                        <exec executable="python" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="${izpack.staging}/utils/wrappers/izpack2exe/izpack2exe.py" />
                                            <arg value="--file" />
                                            <arg value="${project.build.directory}/${project.build.finalName}-Installer.jar" />
                                            <arg value="--with-7z=7za" />
                                            <arg value="--no-upx" />
                                            <arg value="--output" />
                                            <arg value="${project.build.directory}/${project.build.finalName}-Installer.exe" />
                                        </exec>


                                    </tasks>
                                </configuration>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                            </execution>


                        </executions>
                    </plugin>

                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>rpm-maven-plugin</artifactId>
                        <version>2.2.0</version>
                        <executions>
                            <execution>
                                <id>attach-rpm</id>
                                <goals>
                                    <goal>attached-rpm</goal>
                                </goals>
                            </execution>
                        </executions>

                        <configuration>
                            <license>MIT License</license>
                            <distribution>provconvert</distribution>
                            <group>Application/Provenance</group>
                            <!-- <icon>src/main/resources/icon.gif</icon> -->
                            <packager>Luc Moreau</packager>
                            <prefix>/usr/local</prefix>
                            <changelogFile>src/changelog</changelogFile>
                            <defineStatements>
                                <defineStatement>_unpackaged_files_terminate_build 0</defineStatement>
                            </defineStatements>
                            <mappings>
                                <mapping>
                                    <directory>/usr/local/lib/provconvert</directory>
                                    <filemode>555</filemode>
                                    <username>root</username>
                                    <groupname>root</groupname>
                                    <sources>
                                        <source>
                                            <location>target/appassembler/</location>
                                        </source>
                                    </sources>
                                </mapping>
                                <mapping>
                                    <directory>/usr/share/doc/provconvert</directory>
                                    <documentation>true</documentation>
                                    <filemode>555</filemode>
                                    <username>root</username>
                                    <groupname>root</groupname>
                                    <sources>
                                        <source>
                                            <location>target/classes/README.txt</location>
                                        </source>
                                        <source>
                                            <location>target/provconvert.txt</location>
                                        </source>
                                        <source>
                                            <location>../../license.txt</location>
                                        </source>
                                        <source>
                                            <location>target/generated-sources/license/THIRD-PARTY.txt</location>
                                        </source>
                                    </sources>
                                </mapping>
                                <mapping>
                                    <directory>/usr/local/man/man1</directory>
                                    <documentation>true</documentation>
                                    <username>root</username>
                                    <groupname>root</groupname>
                                    <sources>
                                        <source>
                                            <location>target/provconvert.1</location>
                                        </source>
                                    </sources>
                                </mapping>

                                <mapping>
                                    <directory>/usr/local/bin</directory>
                                    <filemode>750</filemode>
                                    <username>root</username>
                                    <groupname>root</groupname>
                                    <sources>
                                        <softlinkSource>
                                            <location>/usr/local/lib/provconvert/bin/provconvert</location>
                                            <destination>provconvert</destination>
                                        </softlinkSource>
                                    </sources>
                                </mapping>
                            </mappings>
                            <preinstallScriptlet>
                                <script>echo "installing now"</script>
                            </preinstallScriptlet>
                            <postinstallScriptlet>
                                <scriptFile>src/main/scripts/postinstall</scriptFile>
                                <fileEncoding>utf-8</fileEncoding>
                            </postinstallScriptlet>
                            <preremoveScriptlet>
                                <scriptFile>src/main/scripts/preremove</scriptFile>
                                <fileEncoding>utf-8</fileEncoding>
                            </preremoveScriptlet>
                        </configuration>
                    </plugin>

                </plugins>
            </build>
        </profile>

        <profile>
            <id>unix</id>
            <activation>
                <os>
                    <family>unix</family>
                </os>
            </activation>
            <build>
                <plugins>

                    <plugin>
                        <artifactId>jdeb</artifactId>
                        <groupId>org.vafer</groupId>
                        <version>1.4</version>
                        <executions>
                            <execution>
                                <phase>package</phase>
                                <goals>
                                    <goal>jdeb</goal>
                                </goals>
                                <configuration>
                                    <verbose>true</verbose>
                                    <snapshotExpand>true</snapshotExpand>
                                    <verbose>true</verbose>
                                    <controlDir>${basedir}/src/deb/control</controlDir>
                                    <dataSet>
                                        <data>
                                            <src>${project.build.directory}/classes/README.txt</src>
                                            <type>file</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/lib/provconvert</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                        <data>
                                            <src>${project.build.directory}/provconvert.txt</src>
                                            <type>file</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/lib/provconvert</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                        <data>
                                            <src>${project.build.directory}/generated-sources/license/THIRD-PARTY.txt</src>
                                            <type>file</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/lib/provconvert</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                        <data>
                                            <src>${project.build.directory}/provconvert.1</src>
                                            <type>file</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/man/man1</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                        <data>
                                            <src>../../license.txt</src>
                                            <type>file</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/lib/provconvert</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                        <data>
                                            <type>link</type>
                                            <symlink>true</symlink>
                                            <linkName>/usr/local/bin/provconvert</linkName>
                                            <linkTarget>/usr/local/lib/provconvert/bin/provconvert</linkTarget>
                                        </data>
                                        <data>
                                            <src>${project.build.directory}/appassembler</src>
                                            <type>directory</type>
                                            <mapper>
                                                <type>perm</type>
                                                <prefix>/usr/local/lib/provconvert</prefix>
                                                <user>root</user>
                                                <group>root</group>
                                            </mapper>
                                        </data>
                                    </dataSet>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>

        <profile>
            <id>macosx-only</id>
            <activation>
                <os>
                    <name>mac os x</name>
                </os>
            </activation>
            <build>
                <plugins>


                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-antrun-plugin</artifactId>
                        <executions>

                            <execution>
                                <id>IzPack-Mac-Executable-From-MAC</id>
                                <phase>install</phase>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                                <configuration>
                                    <tasks>
                                        <exec executable="touch" dir="${izpack.staging}/utils/wrappers/izpack2app/">
                                            <arg value="Mac-App-Template" />
                                        </exec>

                                        <exec executable="python" dir="${project.build.directory}">
                                            <arg value="${izpack.staging}/utils/wrappers/izpack2app/izpack2app.py" />
                                            <arg value="${project.build.finalName}-Installer.jar" />
                                            <arg value="${project.build.finalName}-Installer.app" />
                                        </exec>

                                        <exec executable="chmod" dir="${project.build.directory}/${project.build.finalName}-Installer.app/Contents/MacOS">
                                            <arg value="a+x" />
                                            <arg value="universalJavaApplicationStub" />
                                        </exec>

                                        <exec executable="mkdir" dir="${project.build.directory}">
                                            <arg value="dmgdir" />
                                        </exec>
                                        <exec executable="mkdir" dir="${project.build.directory}/dmgdir">
                                            <arg value="${project.build.finalName}-Installer.app" />
                                        </exec>

                                        <copy todir="${project.build.directory}/dmgdir/${project.build.finalName}-Installer.app">
                                            <fileset dir="${project.build.directory}/${project.build.finalName}-Installer.app" />
                                        </copy>

                                        <exec executable="chmod" dir="${project.build.directory}/dmgdir/${project.build.finalName}-Installer.app/Contents/MacOS">
                                            <arg value="a+x" />
                                            <arg value="universalJavaApplicationStub" />
                                        </exec>

                                        <exec executable="echo" dir="${project.build.directory}/dmgdir" output="${project.build.directory}/dmgdir/README.txt">
                                            <arg value="Please run installer to install provconvert." />
                                            <arg value="Make sure you can install applications from anywhere: see http://osxdaily.com/2016/09/27/allow-apps-from-anywhere-macos-gatekeeper/" />
                                        </exec>

                                        <exec executable="hdiutil" dir="${project.build.directory}">
                                            <arg value="create" />
                                            <arg value="-volname" />
                                            <arg value="provconvert" />
                                            <arg value="-srcfolder" />
                                            <arg value="dmgdir" />
                                            <arg value="-ov" />
                                            <arg value="-format" />
                                            <arg value="UDZO" />
                                            <arg value="${project.build.finalName}.dmg" />
                                        </exec>

                                    </tasks>
                                </configuration>
                            </execution>


                            <execution>
                                <id>IzPack-Win-Executable-From-Mac</id>
                                <phase>install</phase>
                                <configuration>
                                    <tasks>
                                        <exec executable="rm" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="7za" />
                                        </exec>

                                        <exec executable="ln" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="-s" />
                                            <arg value="/Applications/7zX.app/Contents/Resources/7za" />
                                            <arg value="7za" />
                                        </exec>


                                        <exec executable="python" dir="${izpack.staging}/utils/wrappers/izpack2exe/">
                                            <arg value="${izpack.staging}/utils/wrappers/izpack2exe/izpack2exe.py" />
                                            <arg value="--file" />
                                            <arg value="${project.build.directory}/${project.build.finalName}-Installer.jar" />
                                            <arg value="--with-7z=7za" />
                                            <arg value="--no-upx" />
                                            <arg value="--output" />
                                            <arg value="${project.build.directory}/${project.build.finalName}-Installer.exe" />
                                        </exec>

                                    </tasks>
                                </configuration>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                            </execution>


                        </executions>
                    </plugin>


                </plugins>
            </build>
        </profile>

    </profiles>






</project>
