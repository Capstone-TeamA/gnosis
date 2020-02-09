FROM python:3.6-alpine

RUN adduser -D gnosis

WORKDIR /home/gnosis

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY gnosis.py config.py boot.sh ./
RUN chmod +X boot.sh

ENV FLASK_APP gnosis.py

RUN chown -R gnosis:gnosis ./

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]

