.EXPORT_ALL_VARIABLES: ;

DOCKER_TAG := $(or ${DOCKER_TAG},${DOCKER_TAG},latest)
DOCKER_REGISTRY := $(or ${DOCKER_REGISTRY},${DOCKER_REGISTRY},docker.io)

CONTAINER_NAME = printit
IMG_NAME = enspirit/printit

prince.image:
	docker build --build-arg handler="prince" . -t $(IMG_NAME):princexml

weasyprint.image:
	docker build --build-arg handler="weasyprint" . -t $(IMG_NAME):weasyprint

all.image:
	docker build --build-arg handler="all" . -t $(IMG_NAME)

test: all.image
	docker run --rm -v $(PWD)/config/printit-example.yml:/home/app/config/printit.yml $(IMG_NAME) bundle exec rake test

images: prince.image weasyprint.image all.image

push-images:
	docker tag $(IMG_NAME) $(DOCKER_REGISTRY)/$(IMG_NAME)
	docker tag $(IMG_NAME):princexml $(DOCKER_REGISTRY)/$(IMG_NAME):princexml
	docker tag $(IMG_NAME):weasyprint $(DOCKER_REGISTRY)/$(IMG_NAME):weasyprint

	docker push $(DOCKER_REGISTRY)/$(IMG_NAME)
	docker push $(DOCKER_REGISTRY)/$(IMG_NAME):princexml
	docker push $(DOCKER_REGISTRY)/$(IMG_NAME):weasyprint
