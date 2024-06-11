#!/bin/bash
#cd "${0%/*}"
cd ../../

PROFILR='nlqa'

#打包agent
echo "================ starting to build bistoury agent ================"
mvn clean package -am -pl bistoury-dist -P$PROFILR -Dmaven.test.skip -Denforcer.skip=true
echo "================ building bistoury agent finished ================"
