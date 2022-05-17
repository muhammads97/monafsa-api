FROM ruby:3.1.1-slim

RUN apt-get update -qq && \
    apt-get install -y build-essential libssl-dev nodejs git libpq-dev less vim nano libsasl2-dev ruby-dev zlib1g-dev curl

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY Gemfile* ./

RUN bundle install

COPY . ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]