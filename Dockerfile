# https://github.com/WorksApplications/elasticsearch-sudachi/releases
ARG ELASTIC_VER=7.17.10
ARG SUDACHI_PLUGIN_VER=3.1.0

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VER}

ARG ELASTIC_VER
ARG SUDACHI_PLUGIN_VER

RUN elasticsearch-plugin install https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v${SUDACHI_PLUGIN_VER}/elasticsearch-${ELASTIC_VER}-analysis-sudachi-${SUDACHI_PLUGIN_VER}.zip

RUN curl -Lo sudachi-dictionary-core.zip http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/sudachi-dictionary-latest-core.zip && \
    unzip sudachi-dictionary-core.zip && \
    mkdir -p /usr/share/elasticsearch/config/sudachi/ && \
    mv ./sudachi-dictionary-*/system_core.dic /usr/share/elasticsearch/config/sudachi/ && \
    rm -rf sudachi-dictionary-core.zip sudachi-dictionary-*/

COPY sudachi.json /usr/share/elasticsearch/config/sudachi/
