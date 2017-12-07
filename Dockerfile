FROM ubuntu:16.04

WORKDIR /root

RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
	curl \
	node-less \
	python3-pip \
	python3-setuptools \
	python3-renderpm \
	xz-utils \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/apt3 | xargs apt install -y --no-install-recommends \
	&& curl -o wkhtmltox.tar.xz -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
	&& echo '3f923f425d345940089e44c1466f6408b9619562 wkhtmltox.tar.xz' | sha1sum -c - \
	&& tar xvf wkhtmltox.tar.xz \
	&& cp wkhtmltox/lib/* /usr/local/lib/ \
	&& cp wkhtmltox/bin/* /usr/local/bin/ \
	&& cp -r wkhtmltox/share/man/man1 /usr/local/share/man/

RUN set -x; \
	pip3 install --upgrade pip \
	&& pip3 install --upgrade setuptools \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip3 | xargs pip install

RUN set -x; \
	adduser --system --quiet --shell=/bin/bash --home=/odoo --gecos 'ODOO' --group odoo \
	&& mkdir /var/log/odoo \
	&& chown odoo:odoo /var/log/odoo \
	&& git clone -b 11.0 https://github.com/odoo/odoo /odoo/odoo-server --depth 1 \
	&& chown -R odoo:odoo /odoo/

COPY odoo.conf /etc/odoo.conf

RUN mkdir -p /odoo/custom \
        && chown -R odoo /odoo/custom

VOLUME ./modules:/odoo/custom/
VOLUME odoo_filestore:/var/lib/odoo

EXPOSE 8069 8071

RUN set -x; \
	chown odoo:odoo /etc/odoo.conf

ENV ODOO_RC /etc/odoo.conf

ENV PATH=/odoo/odoo-server/:$PATH
COPY ./entrypoint.sh /

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo-bin"]
