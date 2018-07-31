extern crate actix_web;
use actix_web::{server, App, HttpRequest};

#[macro_use]
extern crate log;
extern crate simple_logger;

use log::Level;

fn index(_req: &HttpRequest) -> &'static str {
    info!("Executing index");
    "Hello Joylabs from Rust!"
}

fn main() {
    simple_logger::init_with_level(Level::Info).unwrap();

    info!("Starting server on localhost:80");
    server::new(|| App::new().resource("/", |r| r.f(index)))
        .bind("localhost:80")
        .unwrap()
        .run();
}