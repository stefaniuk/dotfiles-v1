TARGETS := $(shell cat $(realpath $(lastword $(MAKEFILE_LIST))) | grep "^[a-z]*:" | awk '{ print $$1; }' | sed 's/://g' | grep -vE 'all|help' | paste -sd "|" -)
NAME := dotfiles
IMAGE := stefaniuk/$(NAME)

all: help

help:
	echo
	echo "Usage:"
	echo
	echo "    make $(TARGETS) [APT_PROXY|APT_PROXY_SSL=ip:port] [FILE=file]"
	echo

build:
	docker build \
		--build-arg APT_PROXY=${APT_PROXY} \
		--build-arg APT_PROXY_SSL=${APT_PROXY_SSL} \
		--tag $(IMAGE) \
		--rm .

start:
	docker stop $(IMAGE) > /dev/null 2>&1 ||:
	docker rm $(IMAGE) > /dev/null 2>&1 ||:
	docker run --detach --interactive --tty \
		--name $(NAME) \
		--hostname $(NAME) \
		--volume $(shell pwd)/..:/project \
		$(IMAGE) \
		/bin/bash --login

stop:
	docker stop $(NAME)

log:
	docker logs --follow $(NAME)

install:
	docker exec --interactive --tty \
		$(NAME) \
		./dotfiles

test:
	docker exec --interactive --tty \
		$(NAME) \
		/bin/bash -cli "system_test --skip-selected-tests"

bash:
	docker exec --interactive --tty \
		$(NAME) \
		/bin/bash --login ||:

clean:
	docker stop $(NAME) > /dev/null 2>&1 ||:
	docker rm $(NAME) > /dev/null 2>&1 ||:

remove: clean
	docker rmi $(IMAGE) > /dev/null 2>&1 ||:

encrypt:
	openssl enc -aes-256-cbc -salt -a -in ${FILE} -out ${FILE}.enc

decrypt:
	openssl enc -aes-256-cbc -d -a -in ${FILE} -out $(shell echo ${FILE} | sed 's/.enc//')

.SILENT:
