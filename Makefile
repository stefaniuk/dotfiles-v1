DIR := $(shell pwd)

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build [NAME=name] [ENVIRONMENT=environment]"
	@echo "    make bash NAME=name"
	@echo "    make clean [NAME=name]"
	@echo

################################################################################
# Targets to manage containers
################################################################################

build:
	@if [ "$(NAME)" = "" ]; then \
		make build NAME=debian; \
	else \
		echo "Building 'dotfiles/$(NAME)' image..."; \
		docker build --tag dotfiles/$(NAME) --rm --file ./test/Dockerfile.$(NAME) .; \
	fi
create:
	@if [ "$(NAME)" = "" ]; then \
		make create NAME=debian; \
	else \
		echo "Creating 'dotfiles-$(NAME)' container..."; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker create --interactive --tty \
			--name dotfiles-$(NAME) \
			--hostname dotfiles-$(NAME) \
			--volume $(DIR):/project \
			dotfiles/$(NAME) \
			/bin/bash --login; \
	fi
bash:
	@echo "Bashing into 'dotfiles-$(NAME)' container..."
	@docker exec --interactive --tty \
		dotfiles-$(NAME) \
		/bin/bash --login
clean:
	@if [ "$(NAME)" = "" ]; then \
		make clean NAME=debian; \
	else \
		echo "Removing 'dotfiles-$(NAME)' container..."; \
		docker rm dotfiles-$(NAME) > /dev/null 2>&1 ||:; \
		docker rmi dotfiles/$(NAME) > /dev/null 2>&1 ||:; \
	fi

################################################################################
# Configuration
################################################################################

.SILENT:
