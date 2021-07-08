FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile ./
#RUN gem update --system && \
#    gem install bundler:2.1.4 && \
#    bundle lock --add-platform aarch64-linux && \
RUN bundle install

COPY . .
EXPOSE 9292
CMD ["rackup", "--host", "0.0.0.0", "-p", "9292"]