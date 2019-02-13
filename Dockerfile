FROM python:3.7

RUN apt-get update \
    && apt-get install -my libzmq3-dev \
    && pip install --upgrade pip \
    && mkdir -p /root/.jupyter \
    && mkdir /notebook

WORKDIR /notebook

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY ./config.json /root/.jupyter/jupyter_notebook_config.json
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Installing nltk_data
RUN python -c "import nltk;nltk.download('punkt');nltk.download('stopwords')"

ENTRYPOINT ["/entrypoint.sh"]
