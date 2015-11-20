DIR := $(shell pwd)
OS := centos

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make all"
	@echo "    make build [NAME=name]"
	@echo "    make test [NAME=name]"
	@echo "    make create|start|stop|bash [NAME=name]"
	@echo "    make clean [NAME=name]"
	@echo

################################################################################
# Targets to manage containers
################################################################################

all: clean build test
build:
	@if [ "$(NAME)" = "" ]; then \
		make build NAME=$(OS); \
	else \
		echo "Building '$(NAME)'..."; \
		docker build --file ./test/Dockerfile.$(NAME) --tag dotfiles/$(NAME) --rm .; \
	fi
test:
	@if [ "$(NAME)" = "" ]; then \
		make test NAME=$(OS); \
	else \
		echo "Testing '$(NAME)'..."; \
		docker stop dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker run --interactive --tty --rm \
			--name dotfiles-$(NAME) \
			--hostname dotfiles-$(NAME) \
			--volume $(DIR):/project \
			dotfiles/$(NAME) \
			./test/run.sh; \
	fi
create:
	@if [ "$(NAME)" = "" ]; then \
		make create NAME=$(OS); \
	else \
		echo "Creating '$(NAME)'..."; \
		docker stop dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker create --interactive --tty \
			--name dotfiles-$(NAME) \
			--hostname dotfiles-$(NAME) \
			--volume $(DIR):/project \
			dotfiles/$(NAME) \
			/bin/bash --login; \
	fi
start:
	@if [ "$(NAME)" = "" ]; then \
		make start NAME=$(OS); \
	else \
		echo "Starting '$(NAME)'..."; \
		docker start dotfiles-$(NAME); \
	fi
stop:
	@if [ "$(NAME)" = "" ]; then \
		make stop NAME=$(OS); \
	else \
		echo "Stopping '$(NAME)'..."; \
		docker stop dotfiles-$(NAME); \
	fi
bash:
	@if [ "$(NAME)" = "" ]; then \
		make bash NAME=$(OS); \
	else \
		make create; \
		make start; \
		docker exec --interactive --tty \
			dotfiles-$(NAME) \
			./test/run.sh; \
		echo "Opening Bash for '$(NAME)'..."; \
		docker exec --interactive --tty \
			dotfiles-$(NAME) \
			/bin/bash --login; \
	fi ||:
clean:
	@if [ "$(NAME)" = "" ]; then \
		make clean NAME=$(OS); \
	else \
		echo "Removing '$(NAME)'..."; \
		docker stop dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rmi dotfiles/$(NAME) > /dev/null 2>&1 ||:; \
	fi

################################################################################
# Configuration
################################################################################

.PHONY: test
.SILENT:
