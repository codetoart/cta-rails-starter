#!/bin/sh

chmod u+x bundle-set-config.sh && ./bundle-set-config.sh
echo ${RAILS_ENV}
RAILS_ENV=${RAILS_ENV} bundle check || RAILS_ENV=${RAILS_ENV} bundle install

RAILS_ENV=${RAILS_ENV} bundle exec rails s -b 0.0.0.0 -p 3030