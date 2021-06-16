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
# FROM nginx:1.17.1-alpine
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY --from=build /usr/src/app/dist /usr/share/nginx/html
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app /app
RUN npm install -g @angular/cli
EXPOSE 4200
CMD ["ng", "serve", "--disable-host-check"]