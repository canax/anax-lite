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
composer install

# Get a Makefile, could be useful
# rsync -a vendor/anax/common/extra/Makefile .
rsync -a /home/mos/git/canax/commons/Makefile Makefile

# Install general development files
# rsync -a vendor/anax/common/{.gitignore,.php*.xml} .
rsync -a /home/mos/git/canax/commons/{.gitignore,test,.circleci,.php*.xml} ./
rsync -a /home/mos/git/canax/commons/.travis_default.yml .travis.yml
rsync -a /home/mos/git/canax/commons/.circleci/config_default.yml .circleci/config.yml
rsync -a /home/mos/git/canax/commons/.codeclimate.yml ./

# Enable to run site in docker
#rsync -a vendor/anax/commons/docker-compose_site.yml docker-compose.yml
rsync -a /home/mos/git/canax/commons/docker-compose_site.yml docker-compose.yml

# Create dirs needed
install -d config src view

# Config for error reporting
#rsync -a vendor/anax/commons/config/error_reporting.php config/
rsync -a /home/mos/git/canax/commons/config/error_reporting.php config/

# Create dir structure for htdocs
# rsync -a vendor/anax/common/extra/htdocs .
install -d htdocs/{css,img,js}
rsync -a /home/mos/git/canax/commons/htdocs/{index.php,favicon.ico,.htaccess*} htdocs/

# # Copy default config for router
# rsync -a vendor/anax/router/config/route2/ config/route/
# rsync -a vendor/anax/router/config/route2.php config/route.php
# sedi "s/route2/route/g" config/route.php
# 
# Copy default config for session
rsync -a vendor/anax/session/config/session.php config/

# Copy default config for url
rsync -a vendor/anax/url/config/url_clean.php config/url.php

# Copy default config for view
rsync -a vendor/anax/view/config/view.php config
