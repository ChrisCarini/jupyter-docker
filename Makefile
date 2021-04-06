container_name = chriscarini/jupyterlab
project_name = chriscarini_jupyterlab
service_name = jupyterlab

# start the container, building if necessary
run lab: build
	@printf "UID=$(id -u)\nGID=$(id -g)\n" > .env

	@echo "Running lab..."
	docker-compose -p $(project_name) up -d

	@# tail the logs until we get the url w/ token...
	@echo 'Waiting for container to start...' \
	&& ( docker-compose -p $(project_name) logs -f $(service_name) & ) | grep -q '127.0.0.1.*token'
	@# Then print the access information.
	@make access

access:
	@docker-compose -p $(project_name) logs $(service_name) | grep -A100 'To access the server,'

# stop the container
stop:
	docker-compose -p $(project_name) stop $(service_name)

login:
	docker-compose -p $(project_name) exec $(service_name) /bin/bash

build:
	docker build -t $(container_name) -f Dockerfile .
	@touch build

rebuild:
	docker build --no-cache -t $(container_name) -f Dockerfile .

clean:
	rm -rf build
	@make stop
	docker-compose -p $(project_name) down --remove-orphans -rmi all 2>/dev/null \
	&& docker-compose -p $(project_name) rm -f \
	&& echo 'Project [$(project_name)] removed.'

