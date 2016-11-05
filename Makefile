DIR := $(shell pwd)
OS := ubuntu

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build|create|start|stop|install|test|bash|clean|remove [APT_PROXY|APT_PROXY_SSL=url]"
	@echo

build:
	@docker build --file ./usr/test/etc/Dockerfile.$(OS) \
		--build-arg APT_PROXY=${APT_PROXY} \
		--build-arg APT_PROXY_SSL=${APT_PROXY_SSL} \
		--tag dotfiles/$(OS) --rm .

create:
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker create --interactive --tty \
		--name dotfiles-$(OS) \
		--hostname $(OS) \
		--volume $(DIR):/project \
		dotfiles/$(OS) \
		/bin/bash --login

start:
	@docker start dotfiles-$(OS)

stop:
	@docker stop dotfiles-$(OS)

install:
	@docker exec --interactive --tty dotfiles-$(OS) \
		./dotfiles \
			--config=bash \
			--minimal

test:
	@docker exec --interactive --tty dotfiles-$(OS) \
		/bin/bash -cli "system_test --skip-selected-tests"

bash:
	@docker exec --interactive --tty dotfiles-$(OS) \
		/bin/bash --login ||:

clean:
	@docker stop dotfiles-$(OS) > /dev/null 2>&1 ||:
	@docker rm dotfiles-$(OS) > /dev/null 2>&1 ||:

remove: clean
	@docker rmi dotfiles/$(OS) > /dev/null 2>&1 ||:
