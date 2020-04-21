# Git repo metadata
TAG = $(shell git describe --tags --always)
GIT_USER_NAME = krwozny
GIT_REPO_NAME = io-lab-docker-ci-public

# Docker repo metadata
DOCKER_USER_NAME = $(GIT_USER_NAME)
DOCKER_REPO_NAME = $(GIT_REPO_NAME)

# Image metadata

# Name of the repository
SCHEMA_NAME = $(DOCKER_USER_NAME)/$(DOCKER_REPO_NAME)
SCHEMA_DESCRIPTION = My image!
SCHEMA_URL = http://example.com

# Vendor set to github user name
SCEHMA_VENDOR = $(GIT_USER_NAME)

SCHEMA_VSC_URL = https://github.com/$(GIT_USER_NAME)/$(GIT_REPO_NAME)

# git commit shirt sha
SCHEMA_VCS_REF = $(git log --pretty=format:'%h' -n 1)

SCHEMA_BUILD_DATE = $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
SCHEMA_BUILD_VERSION = v1.0

SCHEMA_CMD = docker run -td $(SCHEMA_NAME)

all: push

image:
  # TODO: this build command is incomplete, add last flag of this command that tags image as latest upon building it
	docker build \
		--build-arg SCHEMA_NAME="$(SCHEMA_NAME)" \
		--build-arg SCHEMA_DESCRIPTION="$(SCHEMA_DESCRIPTION)" \
		--build-arg SCHEMA_URL="$(SCHEMA_URL)" \
		--build-arg SCEHMA_VENDOR="$(SCEHMA_VENDOR)" \
		--build-arg SCHEMA_VSC_URL="$(SCHEMA_VSC_URL)" \
		--build-arg SCHEMA_VCS_REF="$(SCHEMA_VCS_REF)" \
		--build-arg SCHEMA_BUILD_DATE="$(SCHEMA_BUILD_DATE)" \
		--build-arg SCHEMA_BUILD_VERSION="$(SCHEMA_BUILD_VERSION)" \
		--build-arg SCHEMA_CMD="$(SCHEMA_CMD)" \
		--network host \
		-t $(SCHEMA_NAME) .
	
  # TODO: last part of this command that tags just built image with a specyfic tag
	docker tag $(SCHEMA_NAME):latest $(SCHEMA_NAME):firstv
	
push: image
	# TODO: two commands, first pushes the latest image, second pushes the image tagged with specyfic tag
	docker push $(SCHEMA_NAME)
	docker push $(SCHEMA_NAME):firstv
	
clean:

.PHONY: clean image push all