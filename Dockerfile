FROM ruby:2.2

COPY ./Gemfile /app/Gemfile
COPY ./*.rb /app/

RUN mkdir /messages

WORKDIR app

RUN bundle install
EXPOSE 9495

CMD ruby app.rb
