extern crate actix_web;
use actix_web::{server, App, HttpRequest};

#[macro_use]
extern crate log;
extern crate simple_logger;

fn index(_req: &HttpRequest) -> &'static str {
    info!("Executing index");
    "Hello Joylabs from Rust!"
}

fn main() {
    simple_logger::init().unwrap();

    info!("Starting server on localhost:80");
    server::new(|| App::new().resource("/", |r| r.f(index)))
        .bind("127.0.0.1:80")
        .unwrap()
        .run();
}