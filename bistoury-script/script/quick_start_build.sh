#!/bin/bash

cd "${0%/*}"

SCRIPT_DIR=`pwd`

cd ../../


PROFILR='dev'

BISTOURY_PROJECT_VERSION=`mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout`
BISTOURY_PACKAGE_FILE="bistoury-$BISTOURY_PROJECT_VERSION"
BISTOURY_PACKAGE_DIR="$SCRIPT_DIR/../../$BISTOURY_PACKAGE_FILE"

#打包agent
echo "================ starting to build bistoury agent ================"
mvn clean package -am -pl bistoury-dist -P$PROFILR -Dmaven.test.skip -Denforcer.skip=true
echo "================ building bistoury agent finished ================"

#打包ui
echo "================ starting to build bistoury ui    ================"
mvn clean package -am -pl bistoury-ui -P$PROFILR -Dmaven.test.skip=true -Denforcer.skip=true
echo "================ building bistoury ui finished    ================"

#打包proxy
echo "================ starting to build bistoury proxy ================"
mvn clean package -am -pl bistoury-proxy -P$PROFILR -Dmaven.test.skip=true -Denforcer.skip=true
echo "================ building bistoury proxy finished ================"

echo "================ starting to build bistoury script ================"
mvn clean package -am -pl bistoury-script -P$PROFILR -Dmaven.test.skip=true -Denforcer.skip=true
echo "================ building bistoury script finished ================"
#
#
#
rm -rf "$~"

# check if directoyr $BISTOURY_PACKAGE_DIR exists, if exists, then delete it, then crate a new one
if [ -d "$BISTOURY_PACKAGE_DIR" ]; then
  rm -rf $BISTOURY_PACKAGE_DIR
fi
mkdir -p $BISTOURY_PACKAGE_DIR

mv bistoury-ui/target/bistoury-ui-bin $BISTOURY_PACKAGE_DIR/bistoury-ui
mv bistoury-proxy/target/bistoury-proxy-bin $BISTOURY_PACKAGE_DIR/bistoury-proxy
mv bistoury-dist/target/bistoury-agent-bin $BISTOURY_PACKAGE_DIR/bistoury-agent
mv bistoury-script/target/bistoury-script-bin $BISTOURY_PACKAGE_DIR/bistoury-script
cp $BISTOURY_PACKAGE_DIR/bistoury-script/script/quick_start.sh $BISTOURY_PACKAGE_DIR
cp $BISTOURY_PACKAGE_DIR/bistoury-script/script/quick_stop.sh $BISTOURY_PACKAGE_DIR
cp -R $BISTOURY_PACKAGE_DIR/bistoury-script/script/h2 $BISTOURY_PACKAGE_DIR

#cd $SCRIPT_DIR
echo `pwd`
echo $BISTOURY_PACKAGE_FILE
tar -czvf $BISTOURY_PACKAGE_DIR"-quick-start.tar.gz" $BISTOURY_PACKAGE_FILE