FROM python:2.7
#ARG uid
#ARG user
RUN apt-get update && \
    apt-get install -y -q \
    libsasl2-dev \
    libldap2-dev \
    python-ldap \
    python-dev \    
    libsasl2-dev \
    libldap2-dev \
    apache2 \
    libapache2-mod-wsgi \
    build-essential \
    gettext \
    supervisor && \       
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR /var/www/html/helios
COPY /helios-server /var/www/html/helios
RUN cd /var/www/html/helios &&\
    pip install -r requirements.txt
    
COPY conf/settings.py /var/www/html/helios/settings.py
COPY conf/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key 
COPY conf/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt 
COPY conf/helios.conf /etc/apache2/sites-available/helios.conf 
COPY conf/helios-ssl.conf /etc/apache2/sites-available/helios-ssl.conf

RUN a2enmod rewrite && \
    a2enmod ssl && \
    a2dissite 000-default.conf && \    
    a2ensite helios-ssl.conf && \
    a2ensite helios.conf && \
    service apache2 restart
    
EXPOSE 80
EXPOSE 443
