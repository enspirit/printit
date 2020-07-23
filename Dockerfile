FROM q8s.quadrabee.com/enspirit/startback-api-2.7:0.7

USER root

RUN apt-get update
RUN apt-get install -y gdebi

ENV HOME /home/app
WORKDIR /home/app

RUN curl https://www.princexml.com/download/prince_13.5-1_debian10_amd64.deb > prince_13.5-1_debian10_amd64.deb
RUN gdebi --non-interactive prince_13.5-1_debian10_amd64.deb

RUN gem install --no-document \
    bundler \
    path

COPY --chown=app:app Gemfile /home/app/Gemfile

RUN cd /home/app && \
    mkdir /home/app/tmp && \
    bundle install --gemfile /home/app/Gemfile

# Install the app (including Gemfile)
COPY --chown=app:app . /home/app

CMD bundle exec rackup -o 0.0.0.0 -p 4567
