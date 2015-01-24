#### maven

##### versioning

    mvn versions:set -DnewVersion=1.0.0-SNAPSHOT
    mvn versions:revert
    mvn versions:commit

##### info

    mvn dependency:tree -Doutput=/path/to/file
    mvn dependency:copy-dependencies
    mvn help:effective-settings
    mvn help:effective-pom
