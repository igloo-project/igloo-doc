#! /bin/bash

while read line; do
find -name "*.java" -o -name "web.xml" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.commons.util.logging.SLF4JLoggingListener/org.iglooproject.slf4j.jul.bridge.SLF4JLoggingListener/g
EOF
