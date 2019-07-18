# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

# Docker build config variables
CREDENTIALS_PATH 								?= /cft/workdir/credentials.json
DOCKER_ORG 											:= gcr.io/cloud-foundation-cicd
HELPER_FUNCTION_PATH            := /cft/home/helper_functions/task_helper_functions.sh
LINT_IMAGE_VERSION 							?= 2.5.0
KITCHEN_TERRAFORM_IMAGE_VERSION ?= 2.3.0
#LINT_IMAGE_REPO_BASE 						:= ${DOCKER_ORG}/cft/lint:${LINT_IMAGE_VERSION}
LINT_IMAGE_REPO_BASE 						:= cft/lint:${LINT_IMAGE_VERSION}
KITCHEN_TERRAFORM_REPO_BASE 		:= ${DOCKER_ORG}/cft/kitchen-terraform:${KITCHEN_TERRAFORM_IMAGE_VERSION}

# All is the first target in the file so it will get picked up when you just run 'make' on its own
all: check_shell check_python check_golang check_terraform check_docker check_base_files check_trailing_whitespace generate_docs

# The .PHONY directive tells make that this isn't a real target and so
# the presence of a file named 'check_shell' won't cause this target to stop
# working
.PHONY: check_shell
check_shell:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_shell"

.PHONY: check_python
check_python:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_python"

.PHONY: check_golang
check_golang:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "golang"

.PHONY: check_terraform
check_terraform:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_terraform"

.PHONY: check_docker
check_docker:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "docker"

.PHONY: check_base_files
check_base_files:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "basefiles"

.PHONY: check_shebangs
check_shebangs:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_bash"

.PHONY: check_trailing_whitespace
check_trailing_whitespace:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_trailing_whitespace"

.PHONY: test_check_headers
test_check_headers:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "test_check_headers"

.PHONY: check_headers
check_headers:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "check_headers"

.PHONY: generate_docs
generate_docs:
	@docker run --rm -it \
		-v $(CURDIR):/cft/workdir \
		--workdir /cft/workdir \
		${LINT_IMAGE_REPO_BASE} \
		/bin/bash -c "generate_docs"

.PHONY: test_integration
test_integration:
	@source test/test.sh
