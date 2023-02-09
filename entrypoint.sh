#!/bin/bash

variables=(
)

for v in ${variables[@]}; do
  echo $v
  for f in $(grep -r $v /usr/share/nginx/html | cut -d':' -f1); do
    echo "$f ==> $v ==> ${!v}"
    sed -i "s|$v|${!v}|g" $f
  done
done

nginx-debug -g "daemon off;"