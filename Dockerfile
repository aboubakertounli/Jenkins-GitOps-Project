FROM eclipse-temurin:17-jre-alpine
VOLUME /tmp

ARG JAR_FILE=target/spring-boot-hello-world-1.0.0-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

ENV JAR_OPTS=""
ENV JAVA_OPTS=""
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar $JAR_OPTS
