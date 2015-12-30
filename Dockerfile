# Dockerfile
FROM greenygh0st/rails-unicorn-nginx:v1.0-ruby2.2.0-nginx1.6.0

# Add here your preinstall lib(e.g. imagemagick, mysql lib, pg lib, ssh config)

#(required) Install Rails App
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

#(required) nginx port number
EXPOSE 80
