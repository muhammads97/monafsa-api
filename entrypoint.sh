#!/bin/bash
set -xe;

rm -rf /app/tmp/pids/server.pid;

bundle install;

rails db:create;

rails db:migrate;

rails assets:precompile;

echo '[+] starting up...'

exec bundle exec "$@"