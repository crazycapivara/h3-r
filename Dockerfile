# Run 'docker build --target rockerh3 -t crazycapivara/rocker-h3-only:latest .',
# if you want to build the image without 'sf'

FROM rocker/tidyverse:3.5.3 AS rockerh3

LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"

ENV BRANCH master

RUN apt-get update \
  && apt-get install -y --no-install-recommends cmake

# RUN git clone --single-branch -b $BRANCH https://github.com/crazycapivara/h3-r.git
COPY . /h3-r

RUN cd h3-r \
  && chmod +x install-h3c.sh \
  && bash ./install-h3c.sh \
  && R -q -e 'devtools::install()' \
  && cd .. \
  && rm -rf h3-r

FROM rockerh3 AS rockerh3sf

RUN apt-get install -y --no-install-recommends \
  libudunits2-dev \
  libgdal-dev

RUN install2.r --error \
  sf \
  leaflet

