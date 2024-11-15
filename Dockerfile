# Étape 1 : Image de build pour compiler le JAR
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app

# Copier les fichiers du projet dans l'image de build
COPY pom.xml .
COPY src ./src

# Compiler le projet et générer le JAR
RUN mvn clean package -DskipTests

# Étape 2 : Image finale pour exécuter le JAR
FROM openjdk:11
WORKDIR /app

# Copier le JAR généré depuis l'image de build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port de l'application
EXPOSE 8020

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]
