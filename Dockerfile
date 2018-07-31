FROM rust:1.27.2

WORKDIR /usr/src/gcp-cd-codelab
COPY . .

RUN cargo install

CMD ["gcp-cd-codelab"]