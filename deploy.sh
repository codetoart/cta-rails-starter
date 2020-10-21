#if [ -f "$DOCKER_COMPOSE_FILE" ]; then
    if [ "$1" = "staging" ]; then
        DOCKER_COMPOSE_FILE=docker-compose.yml
        #git checkout dev || { echo 'git checkout failed' ; exit 1; }
        #git pull origin dev  || { echo 'git pull failed' ; exit 1; }
    elif [ "$1" = "prod" ]; then
        DOCKER_COMPOSE_FILE=docker-compose.yml
        git checkout master || { echo 'git checkout failed' ; exit 1; }
        git pull origin master || { echo 'git pull failed' ; exit 1; }
    elif [ "$1" = "development" ]; then
        DOCKER_COMPOSE_FILE=docker-compose.$1.yml
        echo "Running development environment"
        rm tmp/pids/server.pid
    else
        echo "Unknown environment"
        exit 1
    fi

    echo $DOCKER_COMPOSE_FILE
    docker-compose -f $DOCKER_COMPOSE_FILE build
    docker-compose -f $DOCKER_COMPOSE_FILE down
    docker-compose -f $DOCKER_COMPOSE_FILE up -d
    docker-compose -f $DOCKER_COMPOSE_FILE exec app bundle exec rails db:migrate
#else
#    echo "$FILE docker-compose file not exists."
#fi