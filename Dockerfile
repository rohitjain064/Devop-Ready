FROM centos:latest
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl]=http://vault.centos.org|g' /etc/yum.repos.d/centOS-*
RUN yum install httpd unzip -y
ADD https://www.free-css.com/assets/files/free-css-templates/download/page269/bonativo.zip /var/www/html
WORKDIR /var/www/html
RUN unzip bonativo.zip
RUN rm -rf bonativo.zip &&\
    cp -rf bonativo/* &&\
    rm -rf bonativo &&\
    touch hello
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
