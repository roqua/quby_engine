FROM registry.roqua.nl/roqua/docker-base-images:ruby-2.6-builder AS base

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

ADD quby.gemspec /app
ADD lib/quby/version.rb /app/lib/quby/version.rb
ADD Gemfile /app
ADD Gemfile.lock /app
ADD Appraisals /app
ADD gemfiles/ /app/gemfiles

RUN bundle config --global jobs `cat /proc/cpuinfo | grep processor | wc -l | xargs -I % expr % - 1`
RUN bundle install
RUN bundle exec appraisal install

ADD . /app
WORKDIR /app

