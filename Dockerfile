FROM amazoncorretto:21-alpine AS build
LABEL maintainer="Bart Milo"
WORKDIR /app
COPY . /app
# Install Maven and dependencies
RUN apk --no-cache add maven && \
  mvn dependency:go-offline
RUN mvn clean install

# Runtime stage
FROM amazoncorretto:21-alpine
LABEL maintainer="Bart Milo"
ENV LANG=C.UTF-8 \
  JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto \
  PATH=$PATH:/usr/lib/jvm/java-21-amazon-corretto/bin
WORKDIR /app
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.jar /app/student-enrolment-management-system.jar
ENTRYPOINT ["java", "-jar", "student-enrolment-management-system.jar"]
