SHELL = /bin/sh
export APP_PORT = 8080
export GIT_HASH = $(shell git show --format=%h --no-patch)
export PROJECT_NAME = http

.PHONY: setup
setup:
	python -m pip install flask

.PHONY: image
image:
	docker build --tag endocode:test .

.PHONY: container
container: image
	docker run --publish ${APP_PORT}:${APP_PORT} --detach endocode:test

.PHONY: run
run:
	python ./app.py

.PHONY: test
test:
	@${SHELL} tests.sh
