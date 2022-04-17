#!/usr/bin/env python3
import argparse
from flask import Flask, request, jsonify
import os
import re
import sys

PORT_OPT = "p"
PORT_LONG_OPT = "port"
PORT_ENV_VAR_NAME = "HTTP_PORT"

app = Flask(__name__)
argparser = argparse.ArgumentParser(
    description=("Run http server"),
    allow_abbrev=False,
)

argparser.add_argument(
    f"-{PORT_OPT}",
    f"--{PORT_LONG_OPT}",
    default="8080",
    help="port to list on",
)


@app.get("/helloworld")
def get_countries():
    name = request.args.get("name", default="helloStranger", type=str)
    split_name = re.sub(
        "([A-Z][a-z]+)", r" \1", re.sub("([A-Z]+)", r" \1", name)
    ).split()
    return " ".join(split_name)


@app.get("/versionz")
def add_country():
    return jsonify(
        [
            {"git_commit_hash": os.getenv("GIT_HASH")},
            {"project_name": os.getenv("PROJECT_NAME")},
        ]
    )


def main(args):
    if os.getenv(PORT_ENV_VAR_NAME):
        app_port = os.getenv(PORT_ENV_VAR_NAME)
    else:
        app_port = args[PORT_LONG_OPT]

    app.run(
        host="localhost",
        port=app_port,
    )


if __name__ == "__main__":
    args = vars(argparser.parse_args())
    sys.exit(0)
