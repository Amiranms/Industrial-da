FROM nginx:alpine

RUN apk add --no-cache curl

COPY wait_until.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wait_until.sh

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY styles.css /usr/share/nginx/html/static/styles.css

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/wait_until.sh"]
