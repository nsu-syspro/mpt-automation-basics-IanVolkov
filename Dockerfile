# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN apt-get update && apt-get install -y jq build-essential
WORKDIR /
COPY . .
RUN make check
ENTRYPOINT ["/build/wordcount"]
