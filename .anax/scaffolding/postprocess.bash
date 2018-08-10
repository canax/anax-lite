#!/usr/bin/env bash
#
# Postprocess scaffold
#
#
# Compatible sed -i.
# https://stackoverflow.com/a/4247319/341137
# arg1: Expression.
# arg2: Filename.
#
sedi()
{
    sed -i.bak "$1" "$2"
    rm -f "$2.bak"
}

#
# Exit with an error message
# $1 the message to display
# $2 an optinal exit code, default is 1
#
function error {
    echo "$1" >&2
    exit "${2:-1}"
}

# Install using composer
[[ $1 = "NO_COMPOSER" ]] || composer install

# Get a Makefile, could be useful
rsync -a vendor/anax/commons/Makefile Makefile

# Install general development files
rsync -a vendor/anax/commons/{.gitignore,.circleci,.php*.xml} ./
rsync -a vendor/anax/commons/.travis_default.yml .travis.yml
rsync -a vendor/anax/commons/.circleci/config_default.yml .circleci/config.yml
rsync -a vendor/anax/commons/.codeclimate.yml ./
rsync -a vendor/anax/commons/test/config_sample.php ./test/
rsync -a vendor/anax/commons/test/Example ./test/

# Enable to run site in docker
rsync -a vendor/anax/commons/docker-compose_site.yml docker-compose.yml

# Create dirs needed
install -d src

# Get configuration for commons.
rsync -a vendor/anax/commons/config/ config/

# Copy default config for configuration
rsync -a vendor/anax/configure/config/ config/

# Copy default config for response
rsync -a vendor/anax/response/config/ config/

# Copy default config for request
rsync -a vendor/anax/request/config/ config/

# Copy default config for router
rsync -a vendor/anax/router/config/ config/
#rsync -a vendor/anax/router/route/ route/

# Copy default config for session
rsync -a vendor/anax/session/config/ config/

# Copy default config for url
rsync -a vendor/anax/url/config/url_clean.php config/url.php
rsync -a vendor/anax/url/config/di/ config/di/

# Create directory structure for htdocs
install -d htdocs/img
rsync -a vendor/anax/commons/htdocs/ htdocs/
