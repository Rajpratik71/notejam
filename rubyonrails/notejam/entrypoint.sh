#!/usr/bin/env bash

rake db:exists && rake db:migrate || rake db:setup
rails server -b 0.0.0.0
