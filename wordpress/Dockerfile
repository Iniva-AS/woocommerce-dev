FROM wordpress:latest

RUN apt-get update && apt-get install -y unzip

# Import woocommerce plugin
RUN curl -o /tmp/woocommerce.zip -SL https://downloads.wordpress.org/plugin/woocommerce.10.2.1.zip \
    && unzip /tmp/woocommerce.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm /tmp/woocommerce.zip

# Install WP-CLI
RUN curl -o /usr/local/bin/wp -SL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp
