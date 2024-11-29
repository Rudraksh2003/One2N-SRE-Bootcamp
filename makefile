DOCKER_IMAGE_NAME = o2n:latest
DOCKER_CONTAINER_NAME = o2n_container
DOCKER_COMPOSE_FILE = docker-compose.yml
all: build run
build:
	docker build -t $(DOCKER_IMAGE_NAME) .

run:
	docker run -it -p 5000:5000 --name $(DOCKER_CONTAINER_NAME) $(DOCKER_IMAGE_NAME)

stop:
	docker stop $(DOCKER_CONTAINER_NAME)
	docker rm $(DOCKER_CONTAINER_NAME)

up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean: stop
	docker rmi $(DOCKER_IMAGE_NAME)

logs:
	docker logs $(DOCKER_CONTAINER_NAME)