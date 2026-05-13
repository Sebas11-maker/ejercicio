# =========================
# BUILD
# =========================
FROM gradle:8.14.3-jdk21-alpine AS builder

WORKDIR /app

COPY . .

# Limitar memoria de Gradle
ENV GRADLE_OPTS="-Xmx512m -XX:MaxMetaspaceSize=256m"

RUN gradle clean bootJar --no-daemon

# =========================
# RUNTIME
# =========================
FROM amazoncorretto:21-alpine

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]