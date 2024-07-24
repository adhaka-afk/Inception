# Using the latest stable version of Alpine Linux
FROM alpine:3.19

# Declaring build arguments to pass database credentials and root password
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS

# Updating package index and installing MariaDB and its client, then cleaning up package cache
RUN apk update && apk add --no-cache mariadb mariadb-client && \
    rm -f /var/cache/apk/*

# Creating the directory for MariaDB runtime, and setting appropriate permissions
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    # Modifying MariaDB configuration to allow networking
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# Initializing the MariaDB data directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copying the script to create the initial database and user into the container
COPY requirements/mariadb/conf/create_db.sh .

# Running the script to create the initial database and user, then removing the script
RUN sh create_db.sh && rm create_db.sh

# Switching to the mysql user to run the MariaDB server with reduced privileges
USER mysql

# Starting the MariaDB server
CMD ["/usr/bin/mysqld", "--skip-log-error"]
