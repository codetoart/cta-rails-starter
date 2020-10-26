#!/bin/sh
bundle check || bundle install -j8 --path=./bundle
bundle exec rails s -b 0.0.0.0 -p 3030