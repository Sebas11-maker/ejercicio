FROM gradle:8.14.3-jdk21-alpine AS builder

WORKDIR /app

COPY . .

ENV GRADLE_OPTS="-Xmx512m -XX:MaxMetaspaceSize=256m"

RUN gradle clean bootJar --no-daemon

FROM amazoncorretto:21-alpine

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar uce-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]