extern crate hyper;
use hyper::{Body, Request, Response, Server};
use hyper::rt::Future;
use hyper::service::service_fn_ok;

#[macro_use]
extern crate log;
extern crate simple_logger;

const PHRASE: &str = "Hello Joylabs from Rust!";

fn hello(_req: Request<Body>) -> Response<Body> {
    info!("Executing hello");
    warn!("Error");
    Response::new(Body::from(PHRASE))
}

fn main() {
    simple_logger::init().unwrap();

    info!("Starting server on port 80");

    let addr = ([0, 0, 0, 0], 80).into();

    let new_svc = || {
        service_fn_ok(hello)
    };

    let server = Server::bind(&addr)
        .serve(new_svc)
        .map_err(|e| warn!("server error: {}", e));

    hyper::rt::run(server);
}