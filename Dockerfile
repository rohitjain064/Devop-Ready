FROM centos:latest
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN CENTOSVER=`cat /etc/centos-release | grep 'CentOS release' | awk '{print $3}'` ; \
    grep -v mirrorlist /etc/yum.repos.d/CentOS-Base.repo \
    | sed -e 's/^#baseurl=/baseurl=/g' \
    | sed -e "s?baseurl=http://mirror.centos.org/centos/\$releasever/?baseurl=https://vault.centos.org/$CENTOSVER/?g" \
    > /etc/yum.repos.d/CentOS-Base.repo.new ; \
    mv -f /etc/yum.repos.d/CentOS-Base.repo.new /etc/yum.repos.d/CentOS-Base.repo

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
