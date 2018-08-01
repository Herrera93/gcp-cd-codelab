FROM rust:1.27.2 as build

WORKDIR /usr/src/gcp-cd-codelab
COPY . .

RUN ls -l

RUN cargo build --release

FROM debian:jessie-slim

COPY --from=build gcp-cd-codelab/target .

RUN zip -r new_target.zip target

RUN ls -l

CMD ["./gcp-cd-codelab"]