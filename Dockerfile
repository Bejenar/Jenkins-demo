FROM adoptopenjdk/openjdk11:alpine-jre as builder
WORKDIR application

COPY target/app.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR application

RUN apk add --no-cache curl

COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./

RUN addgroup --system --gid 1001 nonroot_usr && \
    adduser --system --home /nonroot_usr --uid 1001 --ingroup nonroot_usr nonroot_usr

USER nonroot_usr

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]