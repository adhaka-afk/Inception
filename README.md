# Inception


## Description:

Inception is a Docker-based infrastructure setup project. The goal is to build a small-scale web hosting environment using Docker containers, adhering to best practices for security, efficiency, and maintainability. We set up multiple services, each running in its own container, and manage their communication through Docker networks.
## Project Structure

**srcs/:** Contains all the configuration files, Dockerfiles, and service-specific directories.

**Makefile:** The Makefile automates the setup of the entire project, building the Docker images and managing the containers using "**docker-compose.yml**".

## Features

**Docker Compose Orchestration:** Manages the setup and communication of services using Docker Compose.

**NGINX with SSL:** An NGINX container configured with SSL (TLSv1.2 or TLSv1.3) to ensure secure communication over HTTPS.

**WordPress + php-fpm:** A container running WordPress with php-fpm, isolated from the web server to follow best practices.

**MariaDB Database:** A dedicated MariaDB container to manage the WordPress database, ensuring data integrity and separation of services.

**Volumes for Data Persistence:** Ensures WordPress files and database storage persist across container restarts.

**Automatic Restart:** Containers restart in case of a crash to maintain service availability.

## Usage 
Run the 'make' command to build and start the Docker containers:

```bash
make
```

To stop all running containers:

```bash
make down
```

To clean up Docker resources:

```bash
make clean or make fclean
```
To restart the containers:

```bash
make restart
```
To view the logs of the running containers:

```bash
make logs
```
## Additional Notes

**Volume Data Persistence:** The data for WordPress and MariaDB is persisted in "/home/${USER}/data/wordpress" and "/home/${USER}/data/mariadb" respectively.

**Environment Variables:** Ensure that you have a .env file in your srcs/ directory with all the necessary environment variables defined.


## 🚀 Next Project

[CPP05](https://github.com/adhaka-afk/CPP05)

## ⏳ Previous Project

[Ft_irc](https://github.com/adhaka-afk/Ft_irc)
