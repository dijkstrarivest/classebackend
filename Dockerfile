# Build Stage
FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
RUN apt-get install maven -y

WORKDIR /app
COPY . .
RUN mvn clean install

# Production Stage
FROM openjdk:17-jdk-slim

EXPOSE 8080

WORKDIR /app
COPY --from=build /app/target/aulas-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]