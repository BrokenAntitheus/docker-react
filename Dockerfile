FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
#/app/build has all the necessary files
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
