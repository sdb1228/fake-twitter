FROM ruby:2.2

COPY ./Gemfile /app/Gemfile
COPY ./*.rb /app/


RUN useradd -u 1000 -M docker \
  && mkdir -p /messages \
  && chown docker /messages


WORKDIR app

RUN bundle install
USER docker
EXPOSE 9495

VOLUME /messages/twitter



CMD ruby app.rb
