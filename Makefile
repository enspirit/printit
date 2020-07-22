install:
	bundle install

image:
	docker build .

ps:
	docker-compose ps

up:
	docker-compose up -d printit

down:
	docker-compose stop printit

restart:
	docker-compose restart printit

bash:
	docker-compose exec printit bash

logs:
	docker-compose logs -f printit
