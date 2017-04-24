#!/bin/bash

# default SERVER_NAME
if [[ -z "$SERVER_NAME" ]]; then
  SERVER_NAME=steem.io
fi

# generate nginx config on the fly and feed in any appropriate environment variables
/bin/bash -c "envsubst '\$SERVER_NAME' < /etc/nginx/site.conf.template > /etc/nginx/sites-enabled/default"
rm /etc/nginx/site.conf.template
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
cp /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf
rm /etc/nginx/nginx.conf.template

# bring up nginx
service nginx start

# start jekyll serving pages
bundle exec jekyll serve
