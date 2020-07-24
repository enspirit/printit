HANDLERS := prince weasyprint

################################################################################
#### Config variables
###

# Load them from an optional .env file
-include .env

# Specify which docker tag is to be used
VERSION := $(or ${VERSION},${VERSION},latest)
DOCKER_REGISTRY := $(or ${DOCKER_REGISTRY},${DOCKER_REGISTRY},docker.io)

TINY = ${VERSION}
MINOR = $(shell echo '${TINY}' | cut -f'1-2' -d'.')
# not used until 1.0
# MAJOR = $(shell echo '${MINOR}' | cut -f'1-2' -d'.')

### global

clean:
	rm -rf Gemfile.lock Dockerfile.*.log Dockerfile.*.built

ps:
	docker-compose ps

down: $(addsuffix .down,$(HANDLERS))
images: $(addsuffix .image,$(HANDLERS))
push-images: $(addsuffix .push-image,$(HANDLERS))

define make-goal
Dockerfile.$1.built: Dockerfile.$1
	docker build -t enspirit/printit:$1 -f Dockerfile.$1 . | tee Dockerfile.$1.log
	touch Dockerfile.$1.built

$1.down:
	docker-compose stop printit.$1

$1.image: Dockerfile.$1.built

$1.up: down $1.image
	docker-compose up -d printit.$1

$1.restart: down
	docker-compose restart printit.$1

$1.logs:
	docker-compose logs -f printit.$1

$1.bash:
	docker-compose exec printit.$1 bash

Dockerfile.$1.pushed: Dockerfile.$1.built
	docker tag enspirit/printit:$1 $(DOCKER_REGISTRY)/enspirit/printit:$1-${TINY}
	docker push $(DOCKER_REGISTRY)/enspirit/printit:$1-$(TINY) | tee -a Dockerfile.$1.log
	docker tag enspirit/printit:$1 $(DOCKER_REGISTRY)/enspirit/printit:$1-${MINOR}
	docker push $(DOCKER_REGISTRY)/enspirit/printit:$1-$(MINOR) | tee -a Dockerfile.$1.log
	# not used until 1.0
	# docker tag enspirit/printit:$1 $(DOCKER_REGISTRY)/enspirit/printit:$1-${MAJOR}
	# docker push $(DOCKER_REGISTRY)/enspirit/printit:$1-$(MAJOR) | tee -a Dockerfile.$1.log
	touch Dockerfile.$1.pushed

$1.push-image: Dockerfile.$1.pushed
endef
$(foreach handler,$(HANDLERS),$(eval $(call make-goal,$(handler))))
