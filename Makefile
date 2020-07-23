install:
	bundle install

image:
	docker-compose build printit

ps:
	docker-compose ps

up: image
	docker-compose up -d printit

down:
	docker-compose stop printit

restart:
	docker-compose restart printit

bash:
	docker-compose exec printit bash

logs:
	docker-compose logs -f printit
