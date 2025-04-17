#!/bin/bash

python ./webhook_server.py

bundle exec jekyll b --watch
