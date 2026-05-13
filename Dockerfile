# =========================
# ETAPA 1 - BUILD
# =========================
FROM gradle:8.14.3-jdk21 AS builder
# Carpeta de trabajo
WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Compilar el proyecto
RUN gradle build --no-daemon

# =========================
# ETAPA 2 - RUNTIME
# =========================
FROM amazoncorretto:21-alpine

WORKDIR /app

# Copiar el JAR generado desde la etapa builder
COPY --from=builder /app/build/libs/*.jar uce-0.0.1-SNAPSHOT.jar

# Puerto de Spring Boot
EXPOSE 8080

# Ejecutar aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]