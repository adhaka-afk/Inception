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
	@echo "Creating directories..."
	mkdir -p $(WP)
	mkdir -p $(DB)
	@echo "Bringing up containers..."
	$(DOCKER_COMPOSE) up -d --build
	@echo "---Containers are up---"

down:
	@echo "Bringing down containers..."
	$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "---Containers are down---"

start:
	@echo "Starting containers..."
	$(DOCKER_COMPOSE) start
	@echo "---Containers are started---"

stop:
	@echo "Stopping containers..."
	$(DOCKER_COMPOSE) stop
	@echo "---Containers are stopped---"

status:
	@echo "Status of Docker containers:"
	docker ps -a

clean: down
	@echo "Cleaning Docker system..."
	docker system prune -a -f
	@[ -d $(WP) ] && sudo rm -rf $(WP)/* || echo "No WordPress data to clean."
	@[ -d $(DB) ] && sudo rm -rf $(DB)/* || echo "No MariaDB data to clean."
	@echo "---Cleaned Docker system and data---"

fclean:
	@echo "Total clean of all Docker configurations and data"
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	@[ -d $(WP) ] && sudo rm -rf $(WP)/* || echo "No WordPress data to clean."
	@[ -d $(DB) ] && sudo rm -rf $(DB)/* || echo "No MariaDB data to clean."
	@echo "---Total clean completed---"

logs:
	@echo "Logs of Docker containers:"
	$(DOCKER_COMPOSE) logs

restart: down
	@echo "Restarting configuration..."
	$(DOCKER_COMPOSE) up -d
	@echo "---Configuration restarted---"

.PHONY: all up down start stop status clean fclean logs restart
