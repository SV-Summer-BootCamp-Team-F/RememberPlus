FROM node:16 as builder
WORKDIR /client
COPY frontend/package.json .
RUN yarn
COPY frontend .
RUN yarn build

FROM nginx
EXPOSE 80

RUN rm /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /client/dist /var/www/frontend