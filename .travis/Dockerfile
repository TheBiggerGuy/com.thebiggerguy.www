FROM debian:buster-slim as base

FROM base as builder

ARG HUGO_VERSION
ARG HUGO_HASH

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install --no-install-recommends -y curl ca-certificates
RUN curl -L --output 'hugo_extended_Linux-64bit.tar.gz' "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
RUN sha256sum 'hugo_extended_Linux-64bit.tar.gz'
RUN echo "${HUGO_HASH}  hugo_extended_Linux-64bit.tar.gz" | sha256sum -c
RUN tar -xvf 'hugo_extended_Linux-64bit.tar.gz' 'hugo'

FROM base

COPY --from=builder hugo /usr/local/bin/hugo
CMD ["hugo", "-s", "/site"]
