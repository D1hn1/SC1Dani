FROM nginx:latest
EXPOSE 8080:80
COPY ./index.html /usr/share/nginx/html/index.html
