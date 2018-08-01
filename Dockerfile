FROM ruby:2.3

RUN apt-get update
RUN apt-get install -y gdebi

ENV HOME /home/app
WORKDIR /home/app

RUN curl https://www.princexml.com/download/prince_12-1_debian8.10_amd64.deb > prince_12-1_debian8.10_amd64.deb
RUN gdebi --non-interactive prince_12-1_debian8.10_amd64.deb

RUN gem install --no-rdoc --no-ri \
    bundler \
    path

COPY . /home/app

RUN bundle install

CMD bundle exec rackup -o 0.0.0.0 -p 4567
