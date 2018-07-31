FROM rust:1.27.2 as build

RUN USER=root cargo new --bin gcp-cd-codelab
WORKDIR /gcp-cd-codelab

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo build --release
RUN rm src/*.rs

COPY ./src ./src

RUN cargo build --release

FROM debian:jessie-slim

COPY --from=build gcp-cd-codelab/target/release/gcp-cd-codelab .

CMD ["./gcp-cd-codelab"]