FROM python:3.10.4-alpine3.15

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /var/www/
RUN mkdir html
RUN chmod +x html
RUN chmod 777 html

WORKDIR /var/www/html

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev && apk add git vim neovim htop nano


ARG TOKEN
ENV TOKEN=${TOKEN}

# Repository
RUN git clone https://${TOKEN}@github.com/CarlosGr10/Viavital.git

RUN python3 -m venv venv
RUN chmod -R 777 venv
RUN source venv/bin/activate
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install --upgrade setuptools

RUN apk add nginx
RUN apk add openrc

RUN rc-update add nginx default

#RUN mkdir /opt/cfdscomplementos && mkdir /opt/cfdsprovee

COPY requeriments.txt .

RUN pip install -r requeriments.txt

ENV PIP_ROOT_USER_ACTION=ignore

# RUN mv /var/www/html/Viavital /var/www/html/template

COPY entrypoint.sh /var/www/html

# Static backup

RUN mkdir /tmp/backup

#RUN mv /var/www/html/template/static/* /tmp/backup

# Create the folder media
RUN mkdir media
RUN chmod +x media
RUN chmod 777 media

# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 8000

WORKDIR /var/www/html

RUN ls 

RUN ["chmod", "+x", "/var/www/html/entrypoint.sh"]

ENTRYPOINT ["sh", "/var/www/html/entrypoint.sh"]