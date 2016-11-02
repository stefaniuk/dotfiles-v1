DIR := $(shell pwd)
OS := ubuntu

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make all|build|create|start|stop|install|test|bash|clean [OS=name]"
	@echo

all: build create start install test stop
build:
	@echo "Building '$(OS)'..."
	@docker build --file ./test/Dockerfile.$(OS) --tag dotfiles/$(OS) --rm .
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
install:
	@echo "Installing 'dotfiles' on '$(OS)'..."
	@docker exec --interactive --tty \
		dotfiles-$(OS) \
		./setup.sh \
			--prepare \
			--install --install-common-tools --install-server-tools \
			--config
test:
	@echo "Testing '$(OS)'..."
	@docker exec --interactive --tty \
		dotfiles-$(OS) \
		/bin/bash -cli "system_test --skip-selected-tests"
bash:
	@echo "Opening command-line on '$(OS)'..."
	@docker exec --interactive --tty \
		dotfiles-$(OS) \
		/bin/bash --login ||:
clean:
	@echo "Removing '$(OS)'..."
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rmi dotfiles/$(OS) > /dev/null 2>&1 ||:

.PHONY: test
.SILENT:
