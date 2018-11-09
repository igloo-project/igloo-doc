#! /bin/bash

while read line; do
find -name '*.java' -exec perl -i -pe "$line" {} ';'
done <<EOF
s/\\\Qorg.iglooproject.commons.util.functional/org.iglooproject.functional/g
s/SerializableFunction(?!2)/SerializableFunction2/g
s/SerializablePredicate(?!2)/SerializablePredicate2/g
s/SerializableSupplier(?!2)/SerializableSupplier2/g
EOF
