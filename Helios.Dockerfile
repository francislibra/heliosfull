FROM python:2.7
ENV user helios
USER root
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

RUN mkdir /home/eleicao && \
    mkdir /var/log/eleicao

COPY /volumes/helios-server /home/eleicao

RUN cd /home/eleicao &&\
    pip install -r requirements.txt   

COPY volumes/certs/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key
COPY volumes/certs/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
COPY volumes/supervisor/eleicao.conf /etc/supervisor/conf.d/eleicao.conf
COPY volumes/apache/eleicao.conf /etc/apache2/sites-available/eleicao.conf
COPY volumes/apache/eleicao-ssl.conf /etc/apache2/sites-available/eleicao-ssl.conf    

RUN a2enmod rewrite && \
    a2enmod ssl && \
    a2dissite 000-default.conf && \    
    a2ensite eleicao-ssl.conf && \
    a2ensite eleicao.conf && \
    service apache2 restart

RUN useradd -m -d /home/${user} ${user} && \ 
    usermod -a -G www-data,root ${user} && \
    chown -R --from=root ${user} /home/eleicao    

WORKDIR /home/eleicao    
EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"] 