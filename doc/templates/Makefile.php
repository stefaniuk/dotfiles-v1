CONTAINER := php
DIR := $(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST)))))

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make all"
	@echo "    make dependencies|runnable|watch"
	@echo "    make test|test-debug|test-short"
	@echo "    make clean"
	@echo

all: clean dependencies runnable
dependencies:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR); composer update'
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR)/public; \
		npm update; \
		bower update'
runnable:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR)/public; grunt'
watch:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash -c '\
		cd $(DIR)/public; grunt watch'
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
clean:
	@rm -rf public/dist/*.map
	@rm -rf public/dist/*.js
	@rm -rf public/dist/*.css
	@rm -rf public/node_modules
	@rm -rf public/vendor
	@rm -rf vendor
	@rm -f composer.lock

.PHONY: test
.SILENT:
