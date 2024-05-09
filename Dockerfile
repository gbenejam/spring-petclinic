# Use the official Maven image to create a build artifact.
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Compile and package the application to an executable JAR
RUN mvn package -DskipTests

# For the runtime base image, use OpenJDK.
FROM openjdk:17-slim
WORKDIR /app
# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
# Run the JAR file
ENTRYPOINT ["java","-jar","app.jar"]
