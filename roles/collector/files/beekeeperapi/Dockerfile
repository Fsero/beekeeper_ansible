FROM library/golang:1.8-stretch
ARG CONFIGFILE
USER root
# Godep for vendoring
RUN curl https://glide.sh/get | sh

# Recompile the standard library without CGO
RUN CGO_ENABLED=0 go install -a std

ENV APP_DIR $GOPATH/src/bitbucket.org/fseros/beekeeper_api
RUN mkdir -p $APP_DIR

# Set the entrypoint
ENTRYPOINT (cd $APP_DIR && ./beekeeper_api)
ADD gocode/src/bitbucket.org/fseros/beekeeper_api $APP_DIR

# Compile the binary and statically link
RUN cd $APP_DIR && CGO_ENABLED=0 /go/bin/glide install
RUN cd $APP_DIR && go build
WORKDIR $APP_DIR
