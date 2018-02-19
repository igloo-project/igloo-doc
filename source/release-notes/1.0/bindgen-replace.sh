#! /bin/bash

while read line; do
find -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Qorg.iglooproject.commons.util.binding.AbstractCoreBinding/org.iglooproject.commons.util.binding.ICoreBinding/g
s/\\\QAbstractCoreBinding/ICoreBinding/g
s/\\\Qorg.bindgen.binding.AbstractBinding/org.bindgen.BindingRoot/g
s/\\\QAbstractBinding/BindingRoot/g
EOF
