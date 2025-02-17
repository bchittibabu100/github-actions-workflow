ARG REGISTRY=jfrog.test.net/plinfharbor


# FROM ${REGISTRY}/base-images/node:22-alpine AS builder
# WORKDIR /usr/src/app/angular
# COPY ./angular/package*.json ./
# RUN npm config set registry https://repo1.test.com:443/artifactory/api/npm/npm-virtual/ && npm install --build-from-resource
# COPY ./angular .
# RUN npm run buildProd
# artifacts will be in /usr/src/app/loopback/client/**


FROM ${REGISTRY}/base-images/node:16-stretch
# RUN mkdir -p /usr/src/app \
#     && chown -R 1000:1000 /usr/src/app

# Install iseries db driver
# Install PreRequisite
WORKDIR /opt/ibm/

# Update stretch repositories. These have been moved to archive.
# Ref: https://unix.stackexchange.com/questions/743839/apt-get-update-failed-to-fetch-debian-amd64-packages-while-building-dockerfile-f/743843#743843
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get clean && \
  apt-get update && \
  apt-get install -y build-essential \
  make \
  unixodbc \
  unixodbc-dev \
	python
## Install IBM iAccessSeries app package
RUN mkdir -p /opt/ibm
COPY ./driver/ibm-iaccess-1.1.0.2-1.0.amd64.deb /opt/ibm/
RUN dpkg -i *.deb
RUN apt-get install -f
COPY ./driver/config/* /etc/

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./loopback/package*.json  ./

RUN npm config set registry https://repo1.test.com:443/artifactory/api/npm/npm-virtual/ && npm install --build-from-resource
 
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY ./loopback .
RUN npm run build
#  COPY --from=builder /usr/src/app/loopback/client ./client

# Make /usr/local/share/ca-certificates writable
RUN chmod -R 0777 /usr/local/share/ca-certificates

HEALTHCHECK --interval=60s --timeout=10s --start-period=2m CMD curl -f http://localhost:3000/apiStatus || exit 1

EXPOSE 80
CMD ["npm", "start"]
