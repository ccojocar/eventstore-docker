# Dockerfile for EventStore http://geteventstore.com/

FROM debian:jessie

MAINTAINER Cosmin Cojocar <cosmin.cojocar@protonmail.ch>

# Install curl
RUN apt-get update && apt-get install -y curl

# Set environment variables
ENV ES_VERSION 3.0.5
ENV ES_HOME /opt/EventStore-OSS-Linux-v$ES_VERSION
ENV EVENTSTORE_DB /data/db
ENV EVENTSTORE_LOG /data/logs

# Download and extract EventStore
RUN curl http://download.geteventstore.com/binaries/EventStore-OSS-Linux-v$ES_VERSION.tar.gz | tar xz --directory /opt

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add volumes
VOLUME $EVENTSTORE_DB
VOLUME $EVENTSTORE_LOG

# Change working directory
WORKDIR $ES_HOME

# Fix "exec format error"
RUN sed -i '1 c #!/bin/bash' run-node.sh

# Run
ENTRYPOINT ["./run-node.sh"]
CMD ["--help"]

# Expose the HTTP and TCP ports
EXPOSE 2113 1113