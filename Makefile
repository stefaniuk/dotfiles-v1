DIR := $(shell pwd)

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
		make build NAME=debian; \
	else \
		echo "Building 'dotfiles/$(NAME)' image..."; \
		docker build --file ./test/Dockerfile.$(NAME) --tag dotfiles/$(NAME) --rm .; \
	fi
test:
	@if [ "$(NAME)" = "" ]; then \
		make test NAME=debian; \
	else \
		echo "Testing 'dotfiles-$(NAME)' container..."; \
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
		make create NAME=debian; \
	else \
		echo "Creating 'dotfiles-$(NAME)' container..."; \
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
		make start NAME=debian; \
	else \
		echo "Starting 'dotfiles-$(NAME)' container..."; \
		docker start dotfiles-$(NAME); \
	fi
stop:
	@if [ "$(NAME)" = "" ]; then \
		make stop NAME=debian; \
	else \
		echo "Stopping 'dotfiles-$(NAME)' container..."; \
		docker stop dotfiles-$(NAME); \
	fi
bash:
	@if [ "$(NAME)" = "" ]; then \
		make bash NAME=debian; \
	else \
		echo "Bashing into 'dotfiles-$(NAME)' container..."; \
		docker exec --interactive --tty \
			dotfiles-$(NAME) \
			/bin/bash --login; \
	fi
clean:
	@if [ "$(NAME)" = "" ]; then \
		make clean NAME=debian; \
	else \
		echo "Removing 'dotfiles-$(NAME)' container..."; \
		docker stop dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rmi dotfiles/$(NAME) > /dev/null 2>&1 ||:; \
	fi

################################################################################
# Configuration
################################################################################

.PHONY: test
.SILENT:
