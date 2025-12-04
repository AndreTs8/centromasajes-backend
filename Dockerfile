# Stage 1: Build the JAR
FROM maven:3.9.2-eclipse-temurin-21 AS build
WORKDIR /app

# Copiamos pom.xml y código fuente
COPY pom.xml .
COPY src ./src

# Compilamos el proyecto y generamos el JAR, sin tests para que sea más rápido
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copiamos el JAR compilado desde la etapa anterior
COPY --from=build /app/target/centromasajes-0.0.1.jar app_centromasajes.jar

# Exponemos el puerto de la app
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "app_centromasajes.jar"]
