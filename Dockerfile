FROM openjdk:17
LABEL "Project"="Java Application"
WORKDIR /app
COPY SmartContactManger-0.0.1-SNAPSHOT.war .
EXPOSE 8087
CMD ["java", "-jar", "SmartContactManger-0.0.1-SNAPSHOT.war"]