## Flow

 * Develop, develop, develop
 * Commit any outstanding changes
 * Verify build passes
 * Update versions to release version
 * Commit release version
 * Run deployment
 * Update versions to next snapshot version
 * Commit new snapshot version
 * Develop, develop, develop and rinse and repeat

## Commands

#### artefact installation

    mvn install:install-file \
        -Dfile=json-service-1.2.3.jar \
        -DgroupId=org.stefaniuk.json \
        -DartifactId=json-service \
        -Dversion=1.2.3 \
        -Dpackaging=jar

#### project info

    mvn dependency:tree -Doutput=/path/to/file
    mvn dependency:copy-dependencies
    mvn help:effective-settings
    mvn help:effective-pom

#### project versioning

    mvn versions:set -DnewVersion=1.0.0-SNAPSHOT
    mvn versions:revert
    mvn versions:commit

#### publish

    mvn clean deploy -P release
    mvn nexus-staging:release # if autoReleaseAfterClose is set to false
    mvn nexus-staging:drop

#### misc

    mvn clean test
    mvn install -DskipTests
    mvn source:jar
    mvn javadoc:javadoc javadoc:jar
