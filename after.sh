#!/bin/bash

set -e

# If AFTER_CWD is set, change into that directory
AFTER_CWD=${AFTER_CWD:-.}
cd $AFTER_CWD

sudo -u vagrant -H bash -c "composer install -n --prefer-dist; \
  if [ ! -f ~/.key_generated ]; then php artisan key:generate; touch ~/.key_generated; fi; \
  touch storage/database.sqlite; \
  touch storage/testing.sqlite; \
  cp .env.acceptance .env; \
  php artisan migrate; \
  php artisan migrate --database=sqlite_testing;"
