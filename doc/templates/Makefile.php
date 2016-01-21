CONTAINER := php
ENVIRONMENT := local
DIR := $(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST)))))

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make dependencies|dependencies-force"
	@echo "    make test|test-debug|test-short"
	@echo "    make clean"
	@echo

# Dependencies
dependencies:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR); \
		composer update'
dependencies-force:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR); \
		rm -rf vendor; rm -f composer.lock; \
		composer install'
# Unit tests
test:
	@if [ "$(NAME)" = "" ]; then \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit --testdox'; \
	else \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit --testdox test/$(NAME)Test.php'; \
	fi
test-debug:
	@if [ "$(NAME)" = "" ]; then \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit --verbose --debug'; \
	else \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit --verbose --debug test/$(NAME)Test.php'; \
	fi
test-short:
	@if [ "$(NAME)" = "" ]; then \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit'; \
	else \
		docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
			cd $(DIR); \
			vendor/bin/phpunit test/$(NAME)Test.php'; \
	fi
# Clean up
clean:
	@rm -rf vendor
	@rm -f composer.lock

.PHONY: test
.SILENT:
