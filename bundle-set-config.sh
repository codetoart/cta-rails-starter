if [ ${RAILS_ENV} = "prod" ]; then 
    RAILS_ENV=${RAILS_ENV} bundle config set without development
fi
