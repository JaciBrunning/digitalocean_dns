FROM ruby:2.6.1-alpine3.8

RUN gem install droplet_kit
COPY update.rb /dodns/update.rb
CMD ruby /dodns/update.rb