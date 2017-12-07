FROM odoo:latest

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/apt3 | xargs apt install -y --no-install-recommends

RUN set -x; \
	pip3 install --upgrade pip \
	&& pip3 install --upgrade setuptools \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip3 | xargs pip install


# Copy entrypoint script and Odoo configuration file
RUN pip3 install num2words
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
