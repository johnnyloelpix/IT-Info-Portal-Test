FROM nginx:alpine
FROM mcr.microsoft.com/appsvc/dotnetcore:lts

ENV PORT 8080
EXPOSE 8080

ENV ASPNETCORE_URLS "http://*:${PORT}"

ENTRYPOINT ["dotnet", "/defaulthome/hostingstart/hostingstart.dll"]

# /cstate will be our volume & building directory
WORKDIR /cstate

# Download the example site
COPY exampleSite /cstate

# Copy files from this repo into themes/cstate
RUN mkdir -p /cstate/themes/cstate
COPY . /cstate/themes/cstate

# Copy entrypoint script into the container image, this runs everytime the container cold-starts.
COPY ./docker/entrypoint.sh /docker-entrypoint.d/10-build-hugo.sh

