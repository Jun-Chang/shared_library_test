FROM centos

RUN yum groupinstall -y "Development tools"
RUN yum -y install openssl openssl-devel readline-devel readline compat-readline5 libxml2-devel libxslt-devel libyaml-devel git

RUN echo "ftp.iij.ad.jp 202.232.140.170\
rpms.famillecollet.com 195.154.241.117" >> /etc/hosts

# php
# php -d extension=sample/php/hello/modules/hello.so -r "hello();"
RUN rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-devel php-mcrypt php-pear && \
    pear install -a CodeGen_PECL

# ruby
# ruby /gopath/sample/ruby/hello.rb
RUN yum install -y wget && \
    cd /usr/local/src && \
    wget ftp://core.ring.gr.jp/pub/lang/ruby/2.2/ruby-2.2.0.tar.gz && \
    tar xvzf ruby-2.2.0.tar.gz && \
    cd ruby-2.2.0 && \
    ./configure --with-opt-dir=/usr/local --enable-shared --enable-option-checking && \
    make && make install

# python
# python sample/python/hello.py

# go
RUN cd /usr/local/src && \
    wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz && \
    mkdir /gopath

COPY lib /gopath/lib
COPY sample /gopath/sample
COPY main.go /gopath/

# go build shared library
RUN cd /gopath && \
    /usr/local/go/bin/go build --buildmode=c-shared -o libhellogopher.so main.go

# php extension
RUN cd /gopath/sample/php && \
    pecl-gen --force hello.xml && \
    cd hello && sed -i -e"s/function_entry/zend_function_entry/g" hello.c && \
    phpize && ./configure && make
