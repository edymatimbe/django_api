FROM python:3.11.4-alpine3.17
LABEL maintainer="edymatimb"

ENV PYTHONUNBUFFERED 1

COPY ./req.txt /tmp/req.txt
COPY ./req.dev.txt /tmp/req.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/req.txt && \
    if [DEV = "true"]; \
        then /py/bin/pip install -r /tmp/req.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user