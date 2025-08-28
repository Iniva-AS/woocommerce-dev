# WooCommerce Dev

This is just a simple WooCommerce development docker image
to make it easy do develop and test WooCommerce plugins and themes.

It's very basic and extends the WordPress image.

### Included:

- WordPress
- WooCommerce
- WP-cli

### Login credentials:

- WP Admin: admin / password
- PHPMyAdmin: root / password

### Usage:

Create a `docker-compose.yml` file:

```yaml
services:
  woo_maria_db:
    image: iniva/woocommerce-dev-mariadb:latest
    ports:
      - 3306:3306
    environment:
      MARIADB_DATABASE: exampledb
      MARIADB_USER: exampleuser
      MARIADB_PASSWORD: examplepass
      MARIADB_ROOT_PASSWORD: foobar

  woo_wordpress:
    image: iniva/woocommerce-dev-wordpress:latest
    ports:
      - 8080:80
    extra_hosts:
      - "host.docker.internal:host-gateway"
    environment:
      WORDPRESS_DB_HOST: woo_maria_db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
      WP_ENVIRONMENT_TYPE: local
```

## Updating the images

Creating a new .sql dump to load into the mariadb image:

```bash
docker exec -it woo_maria_db mysqldump -h 127.0.0.1 -u root -pfoobar exampledb > mariadb/init.sql
```

Building and pushing the image:

```bash
make deploy
```
