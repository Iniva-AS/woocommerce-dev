FROM wordpress:latest

RUN apt-get update && apt-get install -y unzip

# Import woocommerce plugin
RUN curl -o /tmp/woocommerce.zip -SL https://downloads.wordpress.org/plugin/woocommerce.10.2.1.zip \
    && unzip /tmp/woocommerce.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm /tmp/woocommerce.zip

# Install WP-CLI
RUN curl -o /usr/local/bin/wp -SL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Install cron
RUN apt-get install -y cron

# Add cron job to run WP cron every minute
RUN echo "* * * * * www-data /usr/local/bin/wp cron event run --due-now --path=/var/www/html" > /etc/cron.d/wp-cron \
    && chmod 0644 /etc/cron.d/wp-cron \
    && crontab /etc/cron.d/wp-cron

# Create startup script to ensure cron runs
RUN echo '#!/bin/bash\nservice cron start\nexec "$@"' > /usr/local/bin/start-services.sh \
    && chmod +x /usr/local/bin/start-services.sh

ENTRYPOINT ["/usr/local/bin/start-services.sh"]
CMD ["apache2-foreground"]
