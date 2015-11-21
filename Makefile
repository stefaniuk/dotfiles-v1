DIR := $(shell pwd)
DEFAULT_OS := ubuntu

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build-all"
	@echo "    make build [OS=name]"
	@echo "    make test [OS=name]"
	@echo "    make create|start|stop|bash [OS=name]"
	@echo "    make clean [OS=name]"
	@echo

################################################################################
# Targets to manage containers
################################################################################

build-all:
	make clean build OS=debian
	make clean build OS=ubuntu
	make clean build OS=centos
	#make clean build OS=scientific
	#make clean build OS=fedora
build:
	@if [ "$(OS)" = "" ]; then \
		make build OS=$(DEFAULT_OS); \
	else \
		echo "Building '$(OS)'..."; \
		docker build --file ./test/Dockerfile.$(OS) --tag dotfiles/$(OS) --rm .; \
	fi
test:
	@if [ "$(OS)" = "" ]; then \
		make test OS=$(DEFAULT_OS); \
	else \
		echo "Testing '$(OS)'..."; \
		docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker run --interactive --tty --rm \
			--name dotfiles-$(OS) \
			--hostname $(OS) \
			--volume $(DIR):/project \
			dotfiles/$(OS) \
			./test/run.sh; \
	fi
create:
	@if [ "$(OS)" = "" ]; then \
		make create OS=$(DEFAULT_OS); \
	else \
		echo "Creating '$(OS)'..."; \
		docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker create --interactive --tty \
			--name dotfiles-$(OS) \
			--hostname $(OS) \
			--volume $(DIR):/project \
			dotfiles/$(OS) \
			/bin/bash --login; \
	fi
start:
	@if [ "$(OS)" = "" ]; then \
		make start OS=$(DEFAULT_OS); \
	else \
		echo "Starting '$(OS)'..."; \
		docker start dotfiles-$(OS); \
	fi
stop:
	@if [ "$(OS)" = "" ]; then \
		make stop OS=$(DEFAULT_OS); \
	else \
		echo "Stopping '$(OS)'..."; \
		docker stop dotfiles-$(OS); \
	fi
bash:
	@if [ "$(OS)" = "" ]; then \
		make bash OS=$(DEFAULT_OS); \
	else \
		make create; \
		make start; \
		docker exec --interactive --tty \
			dotfiles-$(OS) \
			./test/run.sh; \
		echo "Opening Bash for '$(OS)'..."; \
		docker exec --interactive --tty \
			dotfiles-$(OS) \
			/bin/bash --login; \
	fi ||:
clean:
	@if [ "$(OS)" = "" ]; then \
		make clean OS=$(DEFAULT_OS); \
	else \
		echo "Removing '$(OS)'..."; \
		docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:; \
		docker rmi dotfiles/$(OS) > /dev/null 2>&1 ||:; \
	fi

################################################################################
# Configuration
################################################################################

.PHONY: test
.SILENT:
