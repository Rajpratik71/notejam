FROM openjdk:8u181-alpine

# https://spring.io/guides/gs/spring-boot-docker/

# Set the locale http://jaredmarkell.com/docker-and-locales/
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8    

VOLUME /tmp
COPY target/*.jar app.jar
COPY prod.application.properties /
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

EXPOSE 8080 8081
HEALTHCHECK --interval=1m --timeout=5s \
  CMD curl -f http://localhost:8080/health || exit 1 