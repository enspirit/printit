FROM q8s.quadrabee.com/enspirit/startback-api-2.7:0.7

USER root
ENV HOME /home/app
WORKDIR /home/app
ARG handler

RUN apt-get update; \
  if [ "$handler" = "prince" ] || [ "$handler" = "all" ]; then \
    apt-get install -y gdebi && \
    curl https://www.princexml.com/download/prince_13.5-1_debian10_amd64.deb > prince_13.5-1_debian10_amd64.deb && \
    gdebi --non-interactive prince_13.5-1_debian10_amd64.deb;\
  fi;\
  if ["$handler" = "weasyprint" ] || [ "$handler" = "all" ]; then \
    apt-get install -y build-essential python3-dev python3-pip \
    python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 \
    libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info && \
    pip3 install --no-cache-dir weasyprint &&\
    apt purge build-essential; \
  fi; \
  gem install --no-document bundler path && \
  apt-get autoremove && \
  apt-get clean

COPY --chown=app:app Gemfile /home/app/Gemfile

RUN cd /home/app && \
    mkdir /home/app/tmp && \
    bundle install --gemfile /home/app/Gemfile

# Install the app (including Gemfile)
COPY --chown=app:app . /home/app

CMD bundle exec puma -t 1:5 -w 1 --preload -p 80

