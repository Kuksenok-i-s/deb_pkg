#!/bin/bash
if [ ! -d /local/builds/binary ]; then
    echo "No binary output was defined, container will not produce any binary files"
    echo "example docker argument \"-v host_directory/binary:/local/builds/binary\""
    exit 1
fi
if [ ! -d /local/builds/sources ]; then
    echo "No source output was defined, container will not produce any source files"
    echo "example docker argument \"-v host_directory/sources:/local/builds/sources\""
    exit 1
fi

tar -czvf ../helloworld-1.0.tar.gz ../helloworld-1.0
DEBEMAIL="kuksyenok.i.s@gmail.com" DEBFULLNAME="Ilya Kuksenok"  dh_make -s -f ../helloworld-1.0.tar.gz --copyright gpl3 -p helloworld -y

sed -i -f update_control.sed debian/control
dpkg-buildpackage -rfakeroot -b -us -ui -uc
cp ../*.deb /local/builds/binary
dpkg-buildpackage -rfakeroot -S -us -ui -uc
cp ../*.dsc /local/builds/sources
cp ../*.debian.tar.xz /local/builds/sources
cp ../*.orig.tar.gz /local/builds/sources

if [ -v USER_ID ] && [ -v GROUP_ID ] ; then
       echo "user_id ${USER_ID} and group_id ${GROUP_ID} are defined"
       echo "setting file permissions with  \"chown -R ${USER_ID}:${GROUP_ID} /local/builds\""
       chown -R ${USER_ID}:${GROUP_ID} /local/builds 
else
       echo "cant found group_id or user_id variables default file permission to 777"
       echo "!!!WARNING!!!"
       echo "This is not recommended, please add this into docker run cmd \" -e USER_ID=\$(id $(whoami) -u) -e GROUP_ID=\$(id $(whoami) -g) \""
       echo "setting file permissions with \"chmod -R 0777 /local/builds\"" 
       chmod -R 0777 /local/builds
fi
echo "binary files"
ls -l  /local/builds/binary

echo "source files"
ls -l  /local/builds/sources
