# Directories
SRC		= srcs/
REQ		= $(SRC)requirements/
COMPOSE	= $(SRC)docker-compose.yml
ENV		= --env-file $(SRC).env

# Paths
DB      = /home/${USER}/data/mariadb
WP      = /home/${USER}/data/wordpress

# Docker Compose commands
DOCKER_COMPOSE = docker-compose -f $(COMPOSE) $(ENV)

all: up

up:
	mkdir -p $(WP)
	mkdir -p $(DB)
	$(DOCKER_COMPOSE) up -d --build
	@echo "---Containers are up---"

down:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "---Containers are down---"

start:
	$(DOCKER_COMPOSE) start
	@echo "---Containers are started---"

stop:
	$(DOCKER_COMPOSE) stop
	@echo "---Containers are stopped---"

status:
	docker ps -a

fclean: down
	rm -rf $(DB) $(WP)
	@echo "---Cleaned mariadb and wordpress data---"

.PHONY: all up down start stop status fclean
