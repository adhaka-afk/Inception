# Using the latest stable Alpine version
FROM alpine:3.19

# Installing nginx and openssl
RUN apk update && \
    apk add --no-cache nginx openssl && \
    rm -f /var/cache/apk/*

# Generating SSL certificates
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/ssl/certs/adhaka.42.fr.crt \
    -keyout /etc/ssl/private/adhaka.42.fr.key \
    -subj "/C=DE/ST=BW/L=HN/O=42School/OU=42HN/CN=adhaka/"

# Copying custom nginx configuration file
COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# Exposing port 443 for HTTPS
EXPOSE 443

# Starting nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]


