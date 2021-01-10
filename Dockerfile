FROM rust:alpine

WORKDIR /app

RUN apk update && \
    apk add musl-dev && \
    cargo install cargo-watch

CMD ["cargo", "watch", "-x", "run"]
