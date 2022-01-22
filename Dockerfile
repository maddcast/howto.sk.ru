FROM python:3.9.2-alpine3.13 as builder

RUN pip3 install mkdocs-material

WORKDIR build
COPY docs .
COPY mkdocs.yml

RUN mkdocs build --site-dir /site


#------------------
FROM nginx:1.17.8-alpine
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /site /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
