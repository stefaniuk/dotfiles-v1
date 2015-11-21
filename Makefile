DIR := $(shell pwd)
OS := debian

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
	#make clean build OS=opensuse
build:
	@echo "Building '$(OS)'..."
	@docker build --file ./test/Dockerfile.$(OS) --tag dotfiles/$(OS) --rm .
test:
	@echo "Testing '$(OS)'..."
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker run --interactive --tty --rm \
		--name dotfiles-$(OS) \
		--hostname $(OS) \
		--volume $(DIR):/project \
		dotfiles/$(OS) \
		./test/run.sh
create:
	@echo "Creating '$(OS)'..."
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker create --interactive --tty \
		--name dotfiles-$(OS) \
		--hostname $(OS) \
		--volume $(DIR):/project \
		dotfiles/$(OS) \
		/bin/bash --login
start:
	@echo "Starting '$(OS)'..."
	@docker start dotfiles-$(OS)
stop:
	@echo "Stopping '$(OS)'..."
	@docker stop dotfiles-$(OS)
bash:
	@make create
	@make start
	@docker exec --interactive --tty \
		dotfiles-$(OS) \
		./test/run.sh
	@echo "Opening Bash for '$(OS)'..."
	@docker exec --interactive --tty \
		dotfiles-$(OS) \
		/bin/bash --login ||:
clean:
	@echo "Removing '$(OS)'..."
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rmi dotfiles/$(OS) > /dev/null 2>&1 ||:

################################################################################
# Configuration
################################################################################

.PHONY: test
.SILENT:
