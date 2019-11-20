FROM golang:1.12-alpine AS build

RUN apk add make git

WORKDIR /go/src/app
COPY . .
RUN make bin-linux

FROM alpine

COPY --from=build /go/src/app/build/linux/nebula /nebula
COPY --from=build /go/src/app/build/linux/nebula-cert /nebula-cert

EXPOSE 4242

ENTRYPOINT ["/nebula"]
