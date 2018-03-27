#! /bin/bash

while read line; do
find .  -type f -name "*.java" -exec perl -p -i -e "${line}" {} \;
done <<EOF
s/\\\Q.userName(/.username(/g
s/\\\QgetUserName(/getUsername(/g
s/\\\QgetByUserName(/getByUsername(/g
s/\\\QsetUserName(/setUsername(/g
s/\\\Q.getByUserNameCaseInsensitive(/.getByUsernameCaseInsensitive(/g
s/\\\Qorg.iglooproject.jpa.security.service.AuthenticationUserNameComparison/org.iglooproject.jpa.security.service.AuthenticationUsernameComparison/g
s/\\\QAuthenticationUserNameComparison/AuthenticationUsernameComparison/g
s/\\\QauthenticationUserNameComparison/authenticationUsernameComparison/g
s/\\\QsetAuthenticationUserNameComparison/setAuthenticationUsernameComparison/g
EOF
