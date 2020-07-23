-include .env # contains HANDLER env. variable
.EXPORT_ALL_VARIABLES: ;

CNAME=printit.${HANDLER}

image:
	docker-compose build ${CNAME}

ps:
	docker-compose ps

up: image
	docker-compose up -d ${CNAME}

down:
	docker-compose stop ${CNAME}

restart:
	docker-compose restart ${CNAME}

bash:
	docker-compose exec ${CNAME} bash

logs:
	docker-compose logs -f ${CNAME}
