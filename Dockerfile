FROM ruby:3.0.3
ENV LANG C.UTF-8
ENV APP_ROOT /app
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# create working directory
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]