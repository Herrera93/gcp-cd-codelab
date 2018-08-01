FROM debian:jessie-slim as unzip
ADD previous_target.zip .
RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean
RUN apt-get install -y zip && rm -rf /var/lib/apt/lists/*
RUN unzip target.zip

FROM rust:1.27.2 as build
WORKDIR /usr/src/gcp-cd-codelab
COPY --from=unzip target .
COPY . .
RUN ls -l
RUN cargo build --release

FROM debian:jessie-slim
COPY --from=build gcp-cd-codelab/target .
RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean
RUN apt-get install -y zip && rm -rf /var/lib/apt/lists/*
RUN zip -r new_target.zip target
RUN ls -l
CMD ["./target/release/gcp-cd-codelab"]