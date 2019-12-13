FROM registry.access.redhat.com/dotnet/dotnet-22-rhel7:2.2-16 AS build

USER root

RUN mkdir /src

WORKDIR /src

RUN echo "test" > test.txt

FROM registry.access.redhat.com/dotnet/dotnet-22-runtime-rhel7:2.2-16

COPY --from=build /src /src
