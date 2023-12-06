FROM openjdk:17-alpine
EXPOSE 8086
ADD target/web-automate.jar web-automate.jar
ENTRYPOINT ["java","-jar","/web-automate.jar"]