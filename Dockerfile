FROM ruby:2.2

COPY ./Gemfile /app/Gemfile
COPY ./*.rb /app/

RUN mkdir /messages

WORKDIR app

RUN bundle install
EXPOSE 9495

RUN useradd -u 1000 -M docker

USER docker

VOLUME /messages/twitter


CMD ruby app.rb
