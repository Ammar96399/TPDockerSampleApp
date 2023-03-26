FROM maven:3.8.3-openjdk-8-slim AS build

WORKDIR /app

COPY pom.xml .

COPY lib ./lib

COPY haarcascades ./haarcascades

COPY src ./src

RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar \
     -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar

RUN mvn -B dependency:go-offline

RUN mvn package

EXPOSE 8080

RUN java -Djava.library.path=/lib -jar target/fatjar-0.0.1-SNAPSHOT.jar