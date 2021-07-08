FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN useradd -ms /bin/bash app
WORKDIR /home/app

COPY Gemfile Gemfile.lock /home/app/

RUN gem install bundler -v 2.0.1
RUN bundle install

ADD . /home/app
RUN chown -R app:app /home/app
USER app

EXPOSE 9292

CMD ["bundle","exec", "rackup","--host", "0.0.0.0", "-p", "9292"]