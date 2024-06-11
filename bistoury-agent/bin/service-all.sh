#!bin/bash

#all_projects=(H5 OrderDaemon OrderService PrizeService LottoDaemon LottoService LottoManager)
#
#for project in ${all_projects[@]}
#do
#  echo "start $project"
#  # check if  directory exists
#  prj_dir=bistoury-agent-$project
#  if [ -d "$prj_dir" ]; then
#    echo "directory $prj_dir exists"
#    $prj_dir/bin/service.sh stop
#  else
#    echo "directory $prj_dir does not exist"
#  fi
##  mkdir -p $prj_dir/bin
##  mkdir -p $prj_dir/conf
##  mkdir -p $prj_dir/lib
##  mkdir -p $prj_dir/bistoury-conf
#  mkdir -p $prj_dir/logs
#
#  cp -R bistoury-agent/bin $prj_dir/bin
#  cp -R bistoury-agent/conf $prj_dir/conf
#  cp -R bistoury-agent/conf $prj_dir/bistoury-conf
#  ln -s bistoury-agent/lib $prj_dir/lib
#done

function create_app {
  # list all project under conf/app
  cd ../../
  all_apps=`ls bistoury-agent/bistoury-conf/app/`
  for conf_file in ${all_apps[@]}
  do
    if [[ $conf_file != *.conf ]]; then
      continue
    fi
    app=${conf_file%.*}
    prj_dir=${app}-agent
    if [ -d "$prj_dir" ]; then
      echo "directory $prj_dir exists"
      $prj_dir/bin/service.sh stop
      rm -rf $prj_dir
    else
      echo "directory $prj_dir does not exist"
    fi
  #  mkdir -p $prj_dir/bin
  #  mkdir -p $prj_dir/conf
  #  mkdir -p $prj_dir/lib
  #  mkdir -p $prj_dir/bistoury-conf
    mkdir -p $prj_dir/logs

    cp -R bistoury-agent/bin $prj_dir/bin
    cp -R bistoury-agent/conf $prj_dir/conf
#    cp -R bistoury-agent/bistoury-conf $prj_dir/bistoury-conf
  # lin lib directory
#    ln -s bistoury-agent/lib $prj_dir/lib
   cp -R bistoury-agent/lib $prj_dir/lib
    # get file content

    file_name=bistoury-agent/bistoury-conf/app/$conf_file
    # append conf to java.additional.conf
    echo " " >> $prj_dir/conf/java.additional.conf
    cat $file_name >> $prj_dir/conf/java.additional.conf
    mapper_file=bistoury-agent/bistoury-conf/app/${app}.properties
    # escape \
    replace_wrapper_variable $mapper_file $prj_dir/conf/wrapper.conf
    echo "\n" >> $prj_dir/conf/wrapper.conf
    cat bistoury-agent/conf/wrapper.additional.conf >> $prj_dir/conf/wrapper.conf
  done
}

function replace_wrapper_variable {
  mapper_file=$1
  replace_file=$2
  for line in `cat $mapper_file`
  do
    key=${line%=*}
    value=${line#*=}
    echo "begin replace: key=$key, value=$value"
    #use awk to replace
    awk -v key="$key" -v value="$value" '{gsub(key,value,$0);print $0}' $replace_file > $replace_file.tmp
    mv $replace_file.tmp $replace_file
  done
}
create_app "$@"






