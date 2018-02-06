FROM odoo:latest

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/gabrielbalog/odoo-docker/master/apt | xargs apt-get install -y --no-install-recommends \
	&& pip3 install wheel \
	&& pip3 install phonenumbers \
	&& pip3 install watchdog

RUN set -x; \
	pip3 install --upgrade pip \
	&& pip3 install --upgrade setuptools \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip3 -O | xargs pip3 install -r pip3\
	&& curl https://raw.githubusercontent.com/odoo/odoo/11.0/requirements.txt -O | xargs pip3 install -r requirements.txt


RUN apt-get install systemd -y \
  && echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf


EXPOSE 8069 8071

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
