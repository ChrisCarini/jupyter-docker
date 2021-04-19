container_name = chriscarini/jupyterlab
project_name = chriscarini_jupyterlab
service_name = jupyterlab

# start the container, building if necessary
run lab: build
	@rm -rf .env
	@printf "NB_USER=$$(echo $$USER)\n" >> .env
	@printf "NB_UID=$$(id -u)\n" >> .env
	@printf "NB_GID=$$(id -g)\n" >> .env
	@printf "UID=$$(id -u)\n" >> .env
	@printf "GID=$$(id -g)\n" >> .env
	@printf "USER=$$(echo $$USER)\n" >> .env

	@echo "Running lab..."
	docker-compose -p $(project_name) up -d

	@# tail the logs until we get the url w/ token...
	@echo 'Waiting for container to start...' \
	&& ( docker-compose -p $(project_name) logs -f $(service_name) & ) | grep -q '127.0.0.1.*token'
	@# Then print the access information.
	@make access

access:
	@docker-compose -p $(project_name) exec $(service_name) bash -c "sudo -u $$USER /opt/conda/bin/jupyter server list" | sed "s/0.0.0.0/$$HOSTNAME/g"

# stop the container
stop:
	docker-compose -p $(project_name) stop $(service_name)

login:
	docker-compose -p $(project_name) exec $(service_name) /bin/bash

log logs:
	docker-compose -p $(project_name) logs -f $(service_name)

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