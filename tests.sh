#!/bin/sh

set -eu

# tests with normal port
make run > /dev/null 2>&1 &
# give the app a second to spin up
sleep 1

APP_PID="$(pgrep --full app.py)"

if ! curl --silent "localhost:${APP_PORT}/helloworld" | grep --quiet "Hello Stranger"; then
    echo "tests.sh: could not reach 'helloworld' endpoint"
    exit 1
fi

if ! curl --silent "localhost:${APP_PORT}/helloworld?name=ConnerCrosby" | grep --quiet "Conner Crosby"; then
    echo "tests.sh: incorrect output when using 'name' parameter on 'helloworld' endpoint"
    exit 1
fi

if ! curl --silent "localhost:${APP_PORT}/versionz" > /dev/null 2>&1; then
    echo "tests.sh: could not reach 'verionz' endpoint"
    exit 1
fi

kill ${APP_PID}

APP_PORT=8081
# tests with custom port
make APP_PORT="${APP_PORT}" run > /dev/null 2>&1 &
# give the app a second to spin up
sleep 1

APP_PID="$(pgrep --full app.py)"

if ! curl --silent "localhost:${APP_PORT}/helloworld" | grep --quiet "Hello Stranger"; then
    echo "tests.sh: could not reach 'helloworld' endpoint"
    exit 1
fi

if ! curl --silent "localhost:${APP_PORT}/helloworld?name=ConnerCrosby" | grep --quiet "Conner Crosby"; then
    echo "tests.sh: incorrect output when using 'name' parameter on 'helloworld' endpoint"
    exit 1
fi

if ! curl --silent "localhost:${APP_PORT}/versionz" > /dev/null 2>&1; then
    echo "tests.sh: could not reach 'verionz' endpoint"
    exit 1
fi

kill ${APP_PID}
exit 0
