FROM alpine:latest
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# install dependencies
RUN apk --no-cache add openssl curl socat

# cache busting argument
ARG ACME_VERSION

# install acme.sh from the latest version available
RUN apk --no-cache add jq &&\
  ACME_VERSION="$(wget -q -O - https://api.github.com/repos/acmesh-official/acme.sh/releases/latest | jq -r .tag_name)" &&\
  curl -s "https://raw.githubusercontent.com/acmesh-official/acme.sh/${ACME_VERSION}/acme.sh" > /usr/local/bin/acme.sh &&\
  chmod +x /usr/local/bin/acme.sh &&\
  apk del jq

ENTRYPOINT ["/usr/local/bin/acme.sh"]
