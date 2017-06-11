FROM library/golang:1.8-stretch

RUN apt-get update
RUN apt-get install -y libgeoip1 geoip-database geoip-database-extra libgeoip-dev sqlite3 sqlite3
# Godep for vendoring
RUN curl https://glide.sh/get | sh

# Recompile the standard library without CGO
RUN CGO_ENABLED=0 go install -a std

ENV APP_DIR $GOPATH/src/bitbucket.org/fseros/sinker_registry_api
RUN mkdir -p $APP_DIR

# Set the entrypoint
ENTRYPOINT (cd $APP_DIR && ./sinker_registry_api)
ADD gocode/src/bitbucket.org/fseros/sinker_registry_api $APP_DIR

RUN cd $APP_DIR && go get github.com/beego/bee
# Compile the binary and statically link
RUN cd $APP_DIR && CGO_ENABLED=0 /go/bin/glide install
RUN cd $APP_DIR && go build
VOLUME /etc/sinker_registry_api 
EXPOSE 38080
