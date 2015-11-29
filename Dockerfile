FROM python:2.7

ENV NODE_VERSION 4.2.2
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

RUN git clone https://github.com/sugyan/tensorflow-mnist /app

WORKDIR /app

RUN pip install -r requirements.txt

RUN npm install

RUN npm run postinstall

EXPOSE 8000

CMD [ "gunicorn", "main:app", "--log-file=-", "--bind=0.0.0.0:8000" ]
