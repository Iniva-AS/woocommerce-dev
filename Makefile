

build-and-run:
	docker rm -f woocommerce-dev || true && \
	docker build -t woocommerce-dev:latest -f wordpress.Dockerfile . && \
	docker run -d -p 8080:80 -p 3306:3306 --name woocommerce-dev woocommerce-dev:latest

dump-db:
	docker exec -it woo_maria_db mysqldump -h 127.0.0.1 -u root -pfoobar exampledb > mariadb/init.sql

deploy:
	@if [ -z "$(VERSION)" ]; then echo "Usage: make deploy VERSION=x.x.x"; exit 1; fi
	docker build -t iniva/woocommerce-dev-mariadb:$(VERSION) -t iniva/woocommerce-dev-mariadb:latest mariadb -f mariadb/Dockerfile --no-cache && \
	docker build -t iniva/woocommerce-dev-wordpress:$(VERSION) -t iniva/woocommerce-dev-wordpress:latest wordpress -f wordpress/Dockerfile --no-cache && \
	docker push iniva/woocommerce-dev-mariadb:$(VERSION) && \
	docker push iniva/woocommerce-dev-mariadb:latest && \
	docker push iniva/woocommerce-dev-wordpress:$(VERSION) && \
	docker push iniva/woocommerce-dev-wordpress:latest
