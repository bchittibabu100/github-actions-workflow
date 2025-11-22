# --- Stage 0: Build (has build deps only here) ---
FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim AS build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /src

# Install build-only packages here (kept out of final image)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      g++ \
      python3-dev \
      python3-pip \
      libmysqlclient-dev \
      libjpeg-dev \
      zlib1g-dev \
      libxml2-dev \
      odbcinst \
 && rm -rf /var/lib/apt/lists/*

COPY . .
RUN dotnet publish -c Release -o /app/publish

# --- Stage 1: Runtime (minimal) ---
FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim AS runtime
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install ONLY runtime packages required by your app.
# Avoid -dev packages here (they cause Xray to report more CVEs).
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      default-jre-headless \
      libbcprov-java \
      libcommons-lang3-java \
      libc6 \
      libjpeg62-turbo \
      libmysqlclient21 \
      zlib1g \
      libxml2 \
      odbcinst \
      python3 \
      python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy published app from build stage
COPY --from=build /app/publish .

# (Optional) create non-root user if image expects it
# RUN useradd -m app && chown -R app:app /app
# USER app

ENTRYPOINT ["dotnet", "YourApp.dll"]
