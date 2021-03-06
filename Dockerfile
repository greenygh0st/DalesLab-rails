# Dockerfile
FROM greenygh0st/rails-unicorn-nginx:latest #v1.0-ruby2.3.1-nginx1.6.0

#Again make sure everything is up-to-date
RUN apt-get update

# Add here your preinstall lib(e.g. imagemagick, mysql lib, pg lib, ssh config)
RUN apt-get -qq -y install libmagickwand-dev imagemagick
RUN apt-get install -qq -y mysql-server mysql-client libmysqlclient-dev

#ENV

#(required) Install Rails App
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock```
ADD . /app
WORKDIR /app

RUN bundle install --without development test
RUN bundle exec rake assets:precompile RAILS_ENV=production
#RUN bundle exec rake db:migrate RAILS_ENV=production
#RUN bundle exec rake db:seed RAILS_ENV=production

#(required) nginx port number
EXPOSE 80
