# SPECIFY BASE GO IMAGE WE ARE BUILDING OUR SERVICE WITH
FROM golang:1.21.3-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app


# We are setting CGO_ENABLED to fale because I am not using any c libraries with my go code 
RUN CGO_ENABLED=0 go build -o  brokerApp ./cmd/api

RUN chmod +x /app/brokerApp



#Now make a new docker image to run our binanry 
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD [ "/app/brokerApp" ]


