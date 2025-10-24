ARG JAVA_VERSION=17
ARG MAVEN_VERSION=3.9.9
ARG DOCKER_REGISTRY_URL="docker.repo1.tvc.com"

FROM centraltvc.jfrog.io/glb-docker-uhg-loc/uhg-goldenimages/jdk:openjdk-17-latest-dev as build
USER root

RUN --mount=type=secret,id=jf-user \
    --mount=type=secret,id=jf-token \
    sh -c 'echo "https://edgeinternal1tvc.tpc.com/artifactory/glb-alpine-apk-chainguard-rem $(cat /run/secrets/jf-user):$(cat /run/secrets/jf-token)" > /etc/apk/auth.conf \
    && echo "https://edgeinternal1tvc.tpc.com/artifactory/glb-alpine-extras-chainguard-rem $(cat /run/secrets/jf-user):$(cat /run/secrets/jf-token)" >> /etc/apk/auth.conf \
    && export HTTP_AUTH="basic:edgeinternal1tvc.tpc.com:$(cat /run/secrets/jf-user):$(cat /run/secrets/jf-token)" \
    && apk update \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/America/Chicago /etc/localtime \
    && echo "America/Chicago" > /etc/timezone'
    apk add maven~=3.9.9

COPY src /build/src
COPY pom.xml /build
COPY settings.xml /build
WORKDIR /build
RUN sed -i '/<servers>/a\
  <server>\
    <id>uhg-snapshots</id>\
    <username>'"$jf-user"'</username>\
    <password>'"$jf-token"'</password>\
  </server>\
  <server>\
    <id>edge</id>\
    <username>'"$jf-user"'</username>\
    <password>'"$jf-token"'</password>\
  </server>' /build/settings.xml
RUN mvn -s settings.xml clean package -DskipTests

FROM centraluhg.jfrog.io/optumpay-docker-np-loc/opay-temurin-alpine-jdk17:stable

# Copy required files
COPY --from=build /build/target/opay-remittance-partner-network.jar /app.jar

COPY ./entrypoint.sh /entrypoint.sh
RUN ["chmod", "+rwx", "/entrypoint.sh"]
RUN ["chmod", "+rwx", "/app.jar"]

# Create spring user and group with specific IDs to use with the securityContext key on the deployment file
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Start the application
EXPOSE 8080
ENTRYPOINT ["/bin/sh","/entrypoint.sh"]
