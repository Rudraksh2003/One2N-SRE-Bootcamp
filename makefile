DOCKER_IMAGE_NAME = o2n:latest
DOCKER_CONTAINER_API1 = o2n_api1
DOCKER_CONTAINER_API2 = o2n_api2
DOCKER_CONTAINER_NGINX = o2n_nginx
DOCKER_CONTAINER_DB = o2n_db
DOCKER_COMPOSE_FILE = docker-compose.yml

all: build up

# Build the Docker image
build:
	docker build -t $(DOCKER_IMAGE_NAME) .

# Run the containers using Docker Compose
up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

# Stop the containers and remove them
down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Stop specific containers
stop:
	docker stop $(DOCKER_CONTAINER_API1) $(DOCKER_CONTAINER_API2) $(DOCKER_CONTAINER_NGINX) $(DOCKER_CONTAINER_DB)
	docker rm $(DOCKER_CONTAINER_API1) $(DOCKER_CONTAINER_API2) $(DOCKER_CONTAINER_NGINX) $(DOCKER_CONTAINER_DB)

# Clean up the Docker image and containers
clean: stop
	docker rmi $(DOCKER_IMAGE_NAME)

# View logs for a specific container
logs-api1:
	docker logs $(DOCKER_CONTAINER_API1)

logs-api2:
	docker logs $(DOCKER_CONTAINER_API2)

logs-nginx:
	docker logs $(DOCKER_CONTAINER_NGINX)

logs-db:
	docker logs $(DOCKER_CONTAINER_DB)

# Build and run the containers using Docker Compose
build-up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d

# View the status of the services (for monitoring)
status:
	docker-compose ps
