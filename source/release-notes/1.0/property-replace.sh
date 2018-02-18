#! /bin/bash

find -name "*PropertyRegistryConfig.java" -exec perl -p -i -e 's/\Qprotected void register(IPropertyRegistry registry)/public void register(IPropertyRegistry registry)/g' {} \;
