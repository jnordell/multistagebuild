FROM registry.access.redhat.com/ubi7/ubi:latest AS builder

RUN yum install -y go-toolset-1.11-golang

WORKDIR /app
COPY go.* ./
RUN scl enable go-toolset-1.11 'go mod download'
COPY . ./

RUN scl enable go-toolset-1.11 'CGO_ENABLED=0 GOOS=linux go build -mod=readonly -v -o server'

FROM registry.access.redhat.com/ubi7/go-toolset

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /server

# Run the web service on container startup.
CMD ["/server"]

#FROM builder

#RUN echo "mulle" > /tmp/mulle
