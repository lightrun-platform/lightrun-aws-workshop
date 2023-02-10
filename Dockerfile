FROM openjdk:11
WORKDIR app

# Set Lightrun key and company names an environment variable
ARG COMPANY_ID=
ARG LIGHTRUN_KEY=

# Download and install lightrun JVM agent
RUN apt-get update && \
 apt-get install unzip && \
  bash -c "$(curl -L "https://app.lightrun.com/public/download/company/${COMPANY_ID}/install-agent.sh?platform=linux")"
COPY ./PrimeMainMR.java ./

# Run Lightrun
RUN javac -g PrimeMainMR.java
ENTRYPOINT ["java", "-agentpath:agent/lightrun_agent.so" ,"PrimeMainMR"]
