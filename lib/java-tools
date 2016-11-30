#!/bin/bash

print_h2 "Ant"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://ant.apache.org/bindownload.cgi | grep 'bin.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://mirrors.ukfast.co.uk/sites/ftp.apache.org//ant/binaries/apache-ant-$ver-bin.tar.gz" \
        --file "apache-ant-$ver-bin.tar.gz"
    tar -zxf apache-ant-$ver-bin.tar.gz
    rm -rf $DIR/usr/applications/ant
    mv apache-ant-$ver $DIR/usr/applications/ant
    rm apache-ant-$ver-bin.tar.gz
fi

print_h2 "Maven"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://maven.apache.org/download.cgi | grep 'bin.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/$ver/binaries/apache-maven-$ver-bin.tar.gz" \
        --file "apache-maven-$ver-bin.tar.gz"
    tar -zxf apache-maven-$ver-bin.tar.gz
    rm -rf $DIR/usr/applications/maven
    mv apache-maven-$ver $DIR/usr/applications/maven
    rm apache-maven-$ver-bin.tar.gz
fi

print_h2 "Gradle"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://gradle.org/gradle-download/ | grep 'bin.zip' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "https://services.gradle.org/distributions/gradle-$ver-bin.zip" \
        --file "gradle-$ver-bin.zip"
    unzip gradle-$ver-bin.zip > /dev/null
    rm -rf $DIR/usr/applications/gradle
    mv gradle-$ver $DIR/usr/applications/gradle
    rm gradle-$ver-bin.zip
fi

print_h2 "Groovy"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://groovy-lang.org/download.html | grep 'apache-groovy-binary-' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "https://dl.bintray.com/groovy/maven/apache-groovy-binary-$ver.zip" \
        --file "apache-groovy-binary-$ver.zip"
    unzip apache-groovy-binary-$ver.zip > /dev/null
    rm -rf $DIR/usr/applications/groovy
    mv groovy-$ver $DIR/usr/applications/groovy
    rm apache-groovy-binary-$ver.zip
fi

print_h2 "Scala"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://www.scala-lang.org/download/ | grep '.tgz' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "http://downloads.lightbend.com/scala/$ver/scala-$ver.tgz" \
        --file "scala-$ver.tgz"
    tar -zxf scala-$ver.tgz
    rm -rf $DIR/usr/applications/scala
    mv scala-$ver $DIR/usr/applications/scala
    rm scala-$ver.tgz
fi
