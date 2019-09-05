#! /bin/bash

while read line; do
find -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s@\\\Qorg.iglooproject.commons.util.FileUtils@org.iglooproject.commons.io.FileUtils@g
s@\\\Qorg.iglooproject.commons.util.registry.TFileRegistry@org.iglooproject.truezip.registry.TFileRegistry@g
EOF
