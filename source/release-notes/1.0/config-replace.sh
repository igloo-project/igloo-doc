#! /bin/bash

while read line; do
find -name "*.java" -o "web.xml" -exec sed -i "$line" {} \;
done <<EOF
s/org.iglooproject.spring.config.AbstractExtendedApplicationContextInitializer/org.iglooproject.config.bootstrap.spring.AbstractExtendedApplicationContextInitializer/g
s/org.iglooproject.spring.config.annotation.ApplicationConfigurerBeanFactoryPostProcessor/org.iglooproject.config.bootstrap.spring.ApplicationConfigurerBeanFactoryPostProcessor/g
s/org.iglooproject.spring.config.ExtendedApplicationContextInitializer/org.iglooproject.config.bootstrap.spring.ExtendedApplicationContextInitializer/g
s/org.iglooproject.spring.config.spring.annotation.ApplicationDescription/org.iglooproject.config.bootstrap.spring.annotations.ApplicationDescription/g
s/org.iglooproject.spring.config.spring.annotation.ConfigurationLocations/org.iglooproject.config.bootstrap.spring.annotations.ConfigurationLocations/g
EOF
