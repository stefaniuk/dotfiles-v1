## Versioning

#### 1. Structure

`{number}.{type}`

where `{number}` is further broken down as `{major}.{minor}.{micro}` and `{type}` indicates a stage of an artefact in the development cycle.

##### Examples

 * 4.0.0.BUILD-SNAPSHOT
 * 4.0.0.M1
 * 4.0.0.M2
 * 4.0.0.RC1
 * 4.0.0.RC2
 * 4.0.0.RELEASE

#### 2. Number Semantics

In general:

 * a `major` version suggests many significant new features and possible breaking of backward compatibility.
 * a `minor` version may also contain serious new features, but should not break compatibility.
 * a `micro` version typically contains bug fixes, improvements and perhaps smaller new features.

#### 3. Type Semantics

There are three types of an artefact:

 * `BUILD-SNAPSHOT` - a release currently in development. Such artefacts are typically produced by a nightly CI build.
 * `M#` - a 'milestone' release. Such artifacts are usually produced manually.
 * `RC#` - a GA release candidate.
 * `RELEASE` - a GA (Generally Available) release.

#### 4. Order

Notice that the following sequence of versions is in ordered ascending both alphabetically and toward GA:

 * 4.0.0.BUILD-SNAPSHOT
 * 4.0.0.M1
 * 4.0.0.RC1
 * 4.0.0.RELEASE

This is intentional.

___

###### References

 1. [Semantic Versioning 2.0.0](http://semver.org/)
 2. [Spring project versioning](https://github.com/spring-projects/spring-build-gradle/wiki/Spring-project-versioning)
