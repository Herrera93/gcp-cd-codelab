FROM rust:1.27.2 as build

WORKDIR /usr/src/gcp-cd-codelab
COPY . .

RUN unzip previous_target.zip

RUN cargo build --release

RUN zip -r new_target.zip target

FROM debian:jessie-slim

COPY --from=build gcp-cd-codelab/target/release/gcp-cd-codelab .
COPY --from=build gcp-cd-codelab/new_target.zip .

CMD ["./gcp-cd-codelab"]