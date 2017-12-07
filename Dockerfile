FROM ubuntu:16.04
MAINTAINER Odoo S.A. <info@odoo.com>

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
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

# Copy entrypoint script and Odoo configuration file
RUN pip3 install num2words
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

ENV PATH=/odoo/odoo-server/:$PATH

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo-bin"]
