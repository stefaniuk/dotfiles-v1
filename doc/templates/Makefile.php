CONTAINER := php
ENVIRONMENT := local
DIR := $(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST)))))

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make dependencies|dependencies-force|dependencies-composer|dependencies-bower"
	@echo "    make test|test-debug|test-short"
	@echo "    make clean"
	@echo

# Dependencies
dependencies: dependencies-composer dependencies-bower
dependencies-force: clean dependencies
dependencies-composer:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR); \
		composer update'
dependencies-bower:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR); \
		bower update'
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
	@rm -rf public/vendor
	@rm -rf vendor
	@rm -f composer.lock

.PHONY: test
.SILENT:
