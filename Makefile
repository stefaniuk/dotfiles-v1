help:
	echo
	echo "Usage:"
	echo
	echo "    make build|create|start|stop|install|test|bash|clean|remove [APT_PROXY|APT_PROXY_SSL=url]"
	echo

build:
	docker build \
		--build-arg APT_PROXY=${APT_PROXY} \
		--build-arg APT_PROXY_SSL=${APT_PROXY_SSL} \
		--tag dotfiles --rm .

create:
	docker stop dotfiles > /dev/null 2>&1 ||:
	docker rm dotfiles > /dev/null 2>&1 ||:
	docker create --interactive --tty \
		--name dotfiles \
		--hostname dotfiles \
		--volume $(shell pwd):/project \
		dotfiles \
		/bin/bash --login

start:
	docker start dotfiles

stop:
	docker stop dotfiles

install:
	docker exec --interactive --tty dotfiles \
		./dotfiles \
			--config=bash \
			--minimal

test:
	docker exec --interactive --tty dotfiles \
		/bin/bash -cli "system_test --skip-selected-tests"

bash:
	docker exec --interactive --tty dotfiles \
		/bin/bash --login ||:

clean:
	docker stop dotfiles > /dev/null 2>&1 ||:
	docker rm dotfiles > /dev/null 2>&1 ||:

remove: clean
	docker rmi dotfiles > /dev/null 2>&1 ||:

.SILENT:
