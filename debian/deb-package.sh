#!/bin/bash

VERSION=`cat  ./version | perl -ne 'chomp; print join(".", splice(@{[split/\./,$_]}, 0, -1), map {++$_} pop @{[split/\./,$_]}), "\n";'`
echo $VERSION > ./version

cd ..

rm -f ./debian/changelog
EDITOR=echo dch --create --newversion $VERSION-1 --package redmine-mail2ticket

debuild -i -d -us -uc -b
rm -fr ./debian/redmine-mail2ticket/



