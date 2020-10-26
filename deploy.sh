DOCKER_COMPOSE_FILE=docker-compose.yml
if [ -f "$DOCKER_COMPOSE_FILE" ]; then
    if [ "$1" = "staging" ]; then
        git checkout dev || { echo 'git checkout failed' ; exit 1; }
        git pull origin dev  || { echo 'git pull failed' ; exit 1; }
    elif [ "$1" = "prod" ]; then
        git checkout master || { echo 'git checkout failed' ; exit 1; }
        git pull origin master || { echo 'git pull failed' ; exit 1; }
    elif [ "$1" = "development" ]; then
        echo "Running development environment"
    else
        echo "Unknown environment"
        exit 1
    fi

    rm tmp/pids/server.pid
    docker-compose -f $DOCKER_COMPOSE_FILE build
    #docker-compose run --rm app bundle check || bundle install -j8 --path=./bundle
    #docker-compose run --rm app ./db-migrate.sh
    docker-compose -f $DOCKER_COMPOSE_FILE down
    docker-compose -f $DOCKER_COMPOSE_FILE up -d
    #docker-compose exec app ./db-migrate.sh

else
   echo "$FILE docker-compose file not exists."
fi