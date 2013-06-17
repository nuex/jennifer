sidekiq-init
============

A Jennifer generator for an Ubuntu-compatible Sidekiq init script.

The original init script was modified from https://raw.github.com/mperham/sidekiq/master/examples/sidekiq.

## Installation

    jen add /path/to/sidekiq-init

## Usage

    jen new sidekiq-init -v app=example \
                         -v app_dir=/var/app/{{app}}/current \
                         -v log=/var/log/sidekiq_{{app}}.log \
                         -v lock=/var/app/locks/sidekiq-{{app}}.lock \
                         -v pid=/var/app/pids/sidekiq-{{app}}.pid
