FROM rust:1.82-slim-bookworm as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
RUN adduser app && chown -R app /app
COPY --from=builder /app/target/release/rust-rest /app/rust-rest
ENV PORT=8080
EXPOSE $PORT
ENTRYPOINT ["./rust-rest"]

