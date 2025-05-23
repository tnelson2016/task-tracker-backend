# Use the official Maven image to build the application
FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app

# Copy all files
COPY . .

# Build the project
RUN ./mvnw clean package -DskipTests

# Use a lightweight JDK base image to run the app
FROM openjdk:17-slim

WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
