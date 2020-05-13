#!/bin/sh

# python manage.py collectstatic --noinput
# python manage.py migrate
# gunicorn django_project.wsgi --bind=0.0.0.0:80

# docker image build --compress -t testing-django-image:latest . && \
# docker container run --publish 8080:8080 --env PROJECT_DB_HOST=docker.for.mac.host.internal --env DEBUG=True --env COMPRESS_ENABLED=True --env COMPRESS_OFFLINE=True --name=testing-django testing-django-:0.0.1
