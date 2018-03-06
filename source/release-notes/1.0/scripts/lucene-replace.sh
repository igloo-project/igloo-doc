#! /bin/bash

while read line; do
find \( -name "*.java" -o -name "web.xml" \) -exec perl -p -i -e "${line}" {} +
done <<EOF
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemFilterFactory@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemFilterFactory@g
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemmer@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemmer@g
s@\\\Qorg.iglooproject.jpa.search.analysis.fr.CoreFrenchMinimalStemFilter@org.iglooproject.lucene.analysis.french.CoreFrenchMinimalStemFilter@g
EOF
