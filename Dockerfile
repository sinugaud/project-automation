FROM openjdk:8
EXPOSE 8080
ADD target/web-automate.jar web-automate.jar
ENTRYPOINT ["java","-jar","/web-automate.jar"]