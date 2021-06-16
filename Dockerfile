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