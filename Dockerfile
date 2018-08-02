FROM rust:1.27.2 as build

# Install zip
RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean
RUN apt-get install -y zip && rm -rf /var/lib/apt/lists/*

# Load cargo cache from previous build
ADD previous_cargo.zip .
RUN unzip -o previous_cargo.zip -d /usr/local/

WORKDIR /gcp-cd-codelab
ADD previous_target.zip .
RUN unzip previous_target.zip
COPY . .
RUN cargo build --release
RUN zip -r new_target.zip target
WORKDIR /usr/local
RUN zip -r /gcp-cd-codelab/new_cargo.zip cargo

FROM debian:jessie-slim
COPY --from=build gcp-cd-codelab/target/release/gcp-cd-codelab .
COPY --from=build gcp-cd-codelab/new_target.zip .
COPY --from=build gcp-cd-codelab/new_cargo.zip .
RUN ls -l
CMD ["./gcp-cd-codelab"]