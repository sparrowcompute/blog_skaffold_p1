ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}
ARG GO_VERSION

RUN echo ok
# init process that enables us to tell go to rebuild/rerun when files have been synced
RUN curl https://raw.githubusercontent.com/sparrowengine/devinit/main/devinit -o /usr/local/bin/devinit && \
  chmod 755 /usr/local/bin/devinit

# You can add any other tools you need here (remember, this is only used for dev so image size/security/etc shouldn't be a concern)
# RUN apt update && apt install -y curl vim

# Set up where our current working dir, where our app code will be stored
ARG WORKDIR=/workspace
WORKDIR ${WORKDIR}

# Copy all files (Make sure you have a good .dockerignore to avoid unnecessary rebuilds!)
COPY * ${WORKDIR}/

# Use signaler to call go run. We could have also built the app and run the binary, but this is simpler
ENTRYPOINT ["sh", "-c", "devinit /usr/local/go/bin/go run ."]

