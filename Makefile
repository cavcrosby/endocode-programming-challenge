SHELL = /usr/bin/sh
export GIT_HASH = $(shell git show --format=%h --no-patch)
export PROJECT_NAME = http

.PHONY: setup
setup:
	python -m pip install flask

.PHONY: run
run:
	python ./app.py
