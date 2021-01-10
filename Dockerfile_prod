FROM rust:alpine AS builder
ARG BIN_NAME=hot_reload_workflow

WORKDIR /app

RUN apk update && \
    apk add musl-dev

# Build only dependencies to speed up subsequent builds
ADD Cargo.toml Cargo.lock ./
RUN mkdir -p src \
    && echo "fn main() {}" > src/main.rs \
    && cargo build --release --locked

# Add all sources and rebuild
ADD src src/

RUN touch src/main.rs && \
    cargo build --release && \
    strip target/release/$BIN_NAME && \
    cp target/release/$BIN_NAME /app_bin


FROM scratch
COPY --from=builder /etc/ssl /etc/ssl
COPY --from=builder /app_bin /app_bin
CMD ["/app_bin"]
