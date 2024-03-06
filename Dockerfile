FROM node:latest as build

WORKDIR /usr/local/app

COPY ./ /usr/local/app/

RUN npm install

RUN npm run build

FROM nginx:mainline-alpine3.18-perl

COPY --from=build /usr/local/app/dist/sample-angular-app /usr/share/nginx/html
COPY nginx-selfsigned.crt /etc/nginx/ssl/nginx-selfsigned.crt
COPY nginx-selfsigned.key /etc/nginx/ssl/nginx-selfsigned.key

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443