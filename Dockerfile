FROM nginx:1.9
MAINTAINER Felix Barbeira <fbarbeira@gmail.com>

ENV KIBANA_VERSION 3.1.2

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN curl -SL https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | \
  tar xzC /usr/share/nginx/html --strip-components 1

WORKDIR /usr/share/nginx/html
ENV ELASTICSEARCH http://localhost:9200/
EXPOSE 80
CMD sed -i -e "/^\s*elasticsearch:.*/ c elasticsearch: '$ELASTICSEARCH'," config.js && nginx -g 'daemon off;'
