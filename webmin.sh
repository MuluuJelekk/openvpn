#!/bin/bash

sudo apt-get install 
perl libnet-ssleay-perl 
openssl libauthen-pam-perl 
libpam-runtime libio-pty-perl 
apt-show-versions python

wget http://www.webmin.com/download/deb/webmin-current.deb
sudo dpkg -i webmin-current.deb
sudo service webmin start
