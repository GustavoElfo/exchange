#!/bin/bash

cd ../../
mkdir -p gui/deploy

set -e

# Edit version
version=0.4.9.9

jarFile="/media/sf_vm_shared_ubuntu14_32bit/Bitsquare-$version.jar"

# Note: fakeroot needs to be installed on linux
$JAVA_HOME/bin/javapackager \
    -deploy \
    -Bruntime="$JAVA_HOME/jre" \
    -BappVersion=$version \
    -Bcategory=Network \
    -Bemail=team@bitsquare.io \
    -BlicenseType=GPLv3 \
    -BlicenseFile=LICENSE \
    -Bicon=package/linux/icon.png \
    -native deb \
    -name Bitsquare \
    -title Bitsquare \
    -vendor Bitsquare \
    -outdir gui/deploy \
    -srcfiles $jarFile:$jdkfixFile \
    -srcfiles "core/src/main/resources/bitsquare.policy" \
    -srcfiles package/linux/LICENSE \
    -appclass io.bitsquare.app.BitsquareAppMain \
    -outfile Bitsquare \
    -BjvmOptions=-Djava.security.manager \
    -BjvmOptions=-Djava.security.debug=failure \
    -BjvmOptions=-Djava.security.policy=file:bitsquare.policy \


# sudo alien -r -c -k gui/deploy/bundles/bitsquare-$version.deb

cp "gui/deploy/bundles/bitsquare-$version.deb" "﻿/home/bitsquare/Desktop/Bitsquare-32bit-$version.deb"
mv "gui/deploy/bundles/bitsquare-$version.deb" "/media/sf_vm_shared_ubuntu14_32bit/Bitsquare-32bit-$version.deb"
# mv "bitsquare-$version-1.i386.rpm" "/media/sf_vm_shared_ubuntu14_32bit/Bitsquare-32bit-$version.rpm"
rm -r gui/deploy/

cd package/linux