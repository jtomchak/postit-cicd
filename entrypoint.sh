#!/bin/sh
# Docker entrypoint script.

# Wait until Postgres is ready
# while ! pg_isready -q -h $DB_HOST -p 5432 -U $DB_USER
# do
#   echo "$(date) - waiting for database to start"
#   sleep 2
# done

# ./prod/rel/postit_cicd/bin/postit_cicd eval PostitCicd.Release.migrate
# Wait until Docker application is running and ready
# while ! pg_isready -q -h $DB_HOST -p 5432 -U $DB_USER
# do
#   echo "$(date) - waiting for database to start"
#   sleep 2
# done

# Start up application
./prod/rel/postit_cicd/bin/postit_cicd start