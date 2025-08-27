

build-and-run:
	docker rm -f woocommerce-dev || true && \
	docker build -t woocommerce-dev:latest -f wordpress.Dockerfile . && \
	docker run -d -p 8080:80 -p 3306:3306 --name woocommerce-dev woocommerce-dev:latest

dump-db:
	docker exec -it woo_maria_db mysqldump -h 127.0.0.1 -u root -pexamplepass exampledb > mariadb/init.sql

deploy:
	docker build -t iniva/woocommerce-dev-mariadb:latest mariadb -f mariadb/Dockerfile --no-cache && \
	docker build -t iniva/woocommerce-dev-wordpress:latest wordpress -f wordpress/Dockerfile --no-cache && \
	docker push iniva/woocommerce-dev-mariadb:latest && \
	docker push iniva/woocommerce-dev-wordpress:latest
