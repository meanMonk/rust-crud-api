# Build stage 

FROM rust:1.69-buster as builder

WORKDIR /app

# Accept the build argument
ARG DATABASE_URL

ENV DATABASE_URL=${DATABASE_URL}

#COPY THE SOURCE CODE.

COPY . .

# Build the application

RUN cargo build --release



# PRODUCTION STAGE 
FROM debian:buster-slim


WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD [ "./rust-crud-api" ]