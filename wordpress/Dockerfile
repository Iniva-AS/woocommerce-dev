FROM wordpress:latest

RUN apt-get update && apt-get install -y unzip

# Import woocommerce plugin
RUN curl -o /tmp/woocommerce.zip -SL https://downloads.wordpress.org/plugin/woocommerce.6.9.1.zip \
    && unzip /tmp/woocommerce.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm /tmp/woocommerce.zip

