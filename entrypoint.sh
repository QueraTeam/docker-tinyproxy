#!/bin/sh

FILTER_FILE="/tmp/tinyproxy/filter"
CONFIG_FILE="/tmp/tinyproxy/tinyproxy.conf" # We use tmp directory to be able to run with non-root user.
USER_CONFIG_FILE="/etc/tinyproxy/tinyproxy.conf"
DEFAULT_CONFIG_FILE="/etc/tinyproxy/tinyproxy.default.conf"

mkdir -p /tmp/tinyproxy

if [ -f "$USER_CONFIG_FILE" ]; then # If the config file exists, use the existing one. Otherwise, use the default one.
  cp "$USER_CONFIG_FILE" "$CONFIG_FILE"
else
  cp "$DEFAULT_CONFIG_FILE" "$CONFIG_FILE"
  sed -i "s|^Allow |#Allow |" "$CONFIG_FILE"

  if [ ! -z $ALLOWED_HOSTS ]; then
    sed -i "s|^#Filter .*|Filter \"${FILTER_FILE}\"|" "$CONFIG_FILE"
    sed -i "s|^#FilterDefaultDeny .*|FilterDefaultDeny Yes|" "$CONFIG_FILE"
    touch $FILTER_FILE
    for host in $(echo $ALLOWED_HOSTS | tr ',' '\n'); do
      echo "$host" >> "$FILTER_FILE"
    done
  fi
fi

exec tinyproxy -d -c $CONFIG_FILE
