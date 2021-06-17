# Dockerized Sample Angular Project

This is the sample Angular project from [Angular website](https://angular.io/guide/example-apps-list).

Link to download the original file [here](https://angular.io/generated/zips/getting-started/getting-started.zip).

For production deployment use NGINX server.

For development environment this is the sample Dockerfile using `ng serve`.  This is using multi stage Dockerfile for build and deployment image.

```Dockerfile
# This deployment is only for dev
# please use NGINX for production
### STAGE 1: Build ###
FROM node:14-alpine AS build
WORKDIR /app
COPY . .
COPY package.json package-lock.json ./
RUN npm update
RUN npm install
RUN npm install -g @angular/cli
RUN npm run build --prod
### STAGE 2: Run ###
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app /app
RUN npm install -g @angular/cli
CMD ng serve --disable-host-check
```



