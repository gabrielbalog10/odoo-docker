FROM odoo:latest

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/gabrielbalog/odoo-docker/master/apt | xargs apt install -y --no-install-recommends

RUN set -x; \
	pip3 install --upgrade pip \
	&& pip3 install --upgrade setuptools \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip3 | xargs pip install

EXPOSE 8069 8071

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
