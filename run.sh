#!/bin/sh

CONFIG_FILE="/etc/tinyproxy/tinyproxy.conf"
FILTER_FILE="/etc/tinyproxy/filter"

sed -i "s|^Allow |#Allow |" "$CONFIG_FILE"

if [ ! -z $ALLOWED_HOSTS ]; then
  sed -i "s|^#Filter .*|Filter \"${FILTER_FILE}\"|" "$CONFIG_FILE"
  sed -i "s|^#FilterDefaultDeny .*|FilterDefaultDeny Yes|" "$CONFIG_FILE"

  touch $FILTER_FILE
  for host in $(echo $ALLOWED_HOSTS | tr ',' '\n'); do
    echo "$host" >> "$FILTER_FILE"
  done
fi

exec tinyproxy -d -c $CONFIG_FILE
