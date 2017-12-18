About
=====

OpenJDK 8 JDK and Gradle 4.1 ready container to build Java projects.

https://hub.docker.com/r/kuralabs/java-dev/

Uses Ubuntu 16.04 as base and installs, among other things:

- openjdk-8-jdk-headless
- gradle
- git
- subversion

Also creates a java user that allows to test as a non-root user
(although it is a sudoer).

Usage
=====

    docker pull kuralabs/java-dev:latest
    docker run -it kuralabs/java-dev:latest bash
