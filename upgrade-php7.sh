#!/usr/bin/env bash
# Upgrade an Amazon Linux EC2 to PHP 7.3
#
# Last tested w/ PHP 7.2 AWS Linux version 2.8.5
#
# Must be ran as sudo:
#     sudo bash upgrade-php7.sh
#
# Can be added to ./.ebextensions/20_php.config like so:
#  container_commands:
#    20_php7_upgrade:
#      command: sudo bash scripts/upgrade-php7.sh

# We will remove instances of PHP matching:
remove=( php56 php70 php71 php72 php73)

# Prep dependencies.
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y https://rpmfind.net/linux/centos/7.7.1908/os/x86_64/Packages/scl-utils-20130529-19.el7.x86_64.rpm
yum install -y https://rpmfind.net/linux/centos/7.7.1908/os/x86_64/Packages/libedit-3.0-12.20121213cvs.el7.x86_64.rpm

set -e
yum-config-manager --enable epel
yum-config-manager --enable remi-php73

# Clean previous versions of PHP for determinism!
set +e
if [[ ! -z "$remove" ]]
  then
  for ver in "${remove[@]}"
  do
    modules=$( rpm -qa --queryformat "%{name}\n" | grep "$ver" )
    if [[ ! -z "$modules" ]]
    then
      echo "Removing $ver"
      for module in "${modules[@]}"
      do
        yum remove $module -y
      done
    fi
  done
fi

# Install PHP 7.3 - Uncommon needs commented out. Uncomment what you need and add dependencies as needed.
set -e
yum install -y php73

# # Not yet supportable by this version of Amazon Linux (without significant risk)
# # yum install -y php73-php-pecl-ssh2
# # yum install -y php73-php-gd
# # yum install -y php73-php-pecl-imagick
# # yum install -y php73-php-pecl-imagick-devel

# # yum install -y php73-php-ast
# yum install -y php73-php-bcmath
# # yum install -y php73-php-brotli
# yum install -y php73-php-cli
# #yum install -y php73-php-common
# # yum install -y php73-php-componere
# # yum install -y php73-php-dba
# # yum install -y php73-php-dbg
# yum install -y php73-php-devel
# # yum install -y php73-php-embedded
# yum install -y php73-php-enchant
# # yum install -y php73-php-fpm
# # Gd will require you to build libpng
# # yum install -y php73-php-geos
# # yum install -y php73-php-gmp
# # yum install -y php73-php-horde-horde-lz4
# yum install -y php73-php-imap
# # yum install -y php73-php-interbase
# yum install -y php73-php-intl
# # yum install -y php73-php-ioncube-loader
# yum install -y php73-php-json
# # yum install -y php73-php-ldap
# # yum install -y php73-php-libvirt
# # yum install -y php73-php-libvirt-doc
# # yum install -y php73-php-litespeed
# # yum install -y php73-php-lz4
# # yum install -y php73-php-maxminddb
# yum install -y php73-php-mbstring
# yum install -y php73-php-mysqlnd
# # yum install -y php73-php-oci8
# yum install -y php73-php-odbc
# yum install -y php73-php-opcache
# yum install -y php73-php-pdo
# # yum install -y php73-php-pdo-dblib
# yum install -y php73-php-pear
# # yum install -y php73-php-pecl-ahocorasick
# # yum install -y php73-php-pecl-amqp
# yum install -y php73-php-pecl-apcu
# yum install -y php73-php-pecl-apcu-bc
# # yum install -y php73-php-pecl-apcu-devel
# # yum install -y php73-php-pecl-apfd
# # yum install -y php73-php-pecl-bitset
# # yum install -y php73-php-pecl-cassandra
# # yum install -y php73-php-pecl-cmark
# # yum install -y php73-php-pecl-couchbase2
# # yum install -y php73-php-pecl-crypto
# # yum install -y php73-php-pecl-dbase
# # yum install -y php73-php-pecl-decimal
# # yum install -y php73-php-pecl-dio
# # yum install -y php73-php-pecl-druid
# # yum install -y php73-php-pecl-ds
# # yum install -y php73-php-pecl-eio
# # yum install -y php73-php-pecl-env
# # yum install -y php73-php-pecl-event
# # yum install -y php73-php-pecl-fann
# # yum install -y php73-php-pecl-gearman
# # yum install -y php73-php-pecl-gender
# # yum install -y php73-php-pecl-geoip
# # yum install -y php73-php-pecl-geospatial
# # yum install -y php73-php-pecl-gmagick
# # yum install -y php73-php-pecl-gnupg
# # yum install -y php73-php-pecl-grpc
# # yum install -y php73-php-pecl-handlebars
# # yum install -y php73-php-pecl-hdr-histogram
# # yum install -y php73-php-pecl-hprose
# # yum install -y php73-php-pecl-hrtime
# # yum install -y php73-php-pecl-http
# # yum install -y php73-php-pecl-http-devel
# yum install -y php73-php-pecl-igbinary
# # yum install -y php73-php-pecl-igbinary-devel
# # yum install -y php73-php-pecl-inotify
# # yum install -y php73-php-pecl-ip2location
# # yum install -y php73-php-pecl-json-post
# # yum install -y php73-php-pecl-krb5
# # yum install -y php73-php-pecl-krb5-devel
# # yum install -y php73-php-pecl-leveldb
# # yum install -y php73-php-pecl-lua
# # yum install -y php73-php-pecl-luasandbox
# # yum install -y php73-php-pecl-lzf
# yum install -y php73-php-pecl-mcrypt
# # yum install -y php73-php-pecl-memcache
# # yum install -y php73-php-pecl-memcached
# # yum install -y php73-php-pecl-memprof
# # yum install -y php73-php-pecl-mogilefs
# # yum install -y php73-php-pecl-molten
# # yum install -y php73-php-pecl-mongodb
# # yum install -y php73-php-pecl-mosquitto
# # yum install -y php73-php-pecl-msgpack
# # yum install -y php73-php-pecl-msgpack-devel
# # yum install -y php73-php-pecl-mustache
# # yum install -y php73-php-pecl-mysql
# # yum install -y php73-php-pecl-mysql-xdevapi
# # yum install -y php73-php-pecl-nsq
# yum install -y php73-php-pecl-oauth
# # yum install -y php73-php-pecl-oci8
# # yum install -y php73-php-pecl-opencensus
# # yum install -y php73-php-pecl-parle
# # yum install -y php73-php-pecl-pdflib
# # yum install -y php73-php-pecl-pq
# # yum install -y php73-php-pecl-propro
# # yum install -y php73-php-pecl-propro-devel
# # yum install -y php73-php-pecl-psr
# # yum install -y php73-php-pecl-psr-devel
# # yum install -y php73-php-pecl-radius
# # yum install -y php73-php-pecl-raphf
# # yum install -y php73-php-pecl-raphf-devel
# # yum install -y php73-php-pecl-rar
# # yum install -y php73-php-pecl-rdkafka
# # yum install -y php73-php-pecl-redis4
# # yum install -y php73-php-pecl-request
# # yum install -y php73-php-pecl-rpminfo
# # yum install -y php73-php-pecl-rrd
# # yum install -y php73-php-pecl-scrypt
# # yum install -y php73-php-pecl-seaslog
# # yum install -y php73-php-pecl-selinux
# # yum install -y php73-php-pecl-solr2
# # yum install -y php73-php-pecl-sphinx
# # yum install -y php73-php-pecl-ssdeep
# # yum install -y php73-php-pecl-stats
# # yum install -y php73-php-pecl-stomp
# # yum install -y php73-php-pecl-svm
# # yum install -y php73-php-pecl-swoole4
# # yum install -y php73-php-pecl-sync
# # yum install -y php73-php-pecl-taint
# # yum install -y php73-php-pecl-tcpwrap
# # yum install -y php73-php-pecl-termbox
# # yum install -y php73-php-pecl-timecop
# # yum install -y php73-php-pecl-trace
# # yum install -y php73-php-pecl-trader
# # yum install -y php73-php-pecl-uploadprogress
# yum install -y php73-php-pecl-uuid
# # yum install -y php73-php-pecl-uv
# # yum install -y php73-php-pecl-varnish
# # yum install -y php73-php-pecl-vips
# # yum install -y php73-php-pecl-vld
# # yum install -y php73-php-pecl-xattr
# # yum install -y php73-php-pecl-xdebug
# # yum install -y php73-php-pecl-xdiff
# # yum install -y php73-php-pecl-xlswriter
# # yum install -y php73-php-pecl-xmldiff
# # yum install -y php73-php-pecl-xmldiff-devel
# # yum install -y php73-php-pecl-xxtea
# # yum install -y php73-php-pecl-yac
# # yum install -y php73-php-pecl-yaconf
# # yum install -y php73-php-pecl-yaconf-devel
# # yum install -y php73-php-pecl-yaf
# # yum install -y php73-php-pecl-yaml
# # yum install -y php73-php-pecl-yar
# # yum install -y php73-php-pecl-yaz
# # yum install -y php73-php-pecl-zip
# # yum install -y php73-php-pecl-zmq
# # yum install -y php73-php-pggi
# # yum install -y php73-php-pgsql
# # yum install -y php73-php-phalcon3
# yum install -y php73-php-phpiredis
# # yum install -y php73-php-pinba
# yum install -y php73-php-process
# # yum install -y php73-php-pspell
# # yum install -y php73-php-recode
# # yum install -y php73-php-smbclient
# # yum install -y php73-php-snappy
# # yum install -y php73-php-snmp
# # yum install -y php73-php-snuffleupagus
# yum install -y php73-php-soap
# # yum install -y php73-php-sodium
# # yum install -y php73-php-sqlsrv
# # yum install -y php73-php-tidy
# # yum install -y php73-php-wkhtmltox
# yum install -y php73-php-xml
# yum install -y php73-php-xmlrpc
# # yum install -y php73-php-zephir-parser
# # yum install -y php73-php-zephir-parser-devel
# # yum install -y php73-php-zstd

# Link to bash
scl enable php73 bash

# Restart Apache.
service httpd restart