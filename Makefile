DIR := $(shell pwd)
OS := ubuntu

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build|create|start|stop|install|test|bash|clean|remove [OS=name] [APT_PROXY|APT_PROXY_SSL=url]"
	@echo

build:
	@echo "Building '$(OS)'..."
	@docker build --file ./usr/test/etc/Dockerfile.$(OS) \
		--build-arg APT_PROXY=${APT_PROXY} \
		--build-arg APT_PROXY_SSL=${APT_PROXY_SSL} \
		--tag dotfiles/$(OS) --rm .
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
	@docker exec --interactive --tty dotfiles-$(OS) \
		./setup.sh --inside-container --update --prepare --install --config
test:
	@echo "Testing '$(OS)'..."
	@docker exec --interactive --tty dotfiles-$(OS) \
		./setup.sh --test
bash:
	@echo "Opening command-line on '$(OS)'..."
	@docker exec --interactive --tty dotfiles-$(OS) \
		/bin/bash --login ||:
clean:
	@echo "Cleaning '$(OS)'..."
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
remove: clean
	@echo "Removing '$(OS)'..."
	@docker rmi dotfiles/$(OS) > /dev/null 2>&1 ||:
