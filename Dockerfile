FROM ubuntu:16.04
LABEL mantainer="info@kuralabs.io"

# Set the locale
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8


# Install base system software
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        sudo ca-certificates \
        bash-completion iproute2 curl nano tree ack-grep unzip \
        subversion git \
    && rm -rf /var/lib/apt/lists/*


# Install Java stack
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        openjdk-8-jdk-headless \
    && rm -rf /var/lib/apt/lists/*


# Install Java modules
RUN curl --location https://services.gradle.org/distributions/gradle-4.1-bin.zip -o gradle.zip \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mkdir -p /opt/ \
    && mv gradle-* /opt/gradle \
    && sudo ln -s /opt/gradle/bin/gradle /usr/local/bin/


# Create development user
RUN addgroup \
        --quiet \
        --gid 1000 \
        java \
    && adduser \
        --quiet \
        --home /home/java \
        --uid 1000 \
        --ingroup java \
        --disabled-password \
        --shell /bin/bash \
        --gecos 'Java' \
        java \
    && usermod \
        --append \
        --groups sudo \
        java \
    && echo 'java ALL=NOPASSWD: ALL' > /etc/sudoers.d/java


USER java
WORKDIR /home/java
