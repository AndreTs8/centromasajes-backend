# Stage 1: Build
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/centromasajes-0.0.1.jar app_centromasajes.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app_centromasajes.jar"]
