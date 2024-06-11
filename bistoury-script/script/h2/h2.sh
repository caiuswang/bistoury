#!/bin/bash

H2_DIR=`pwd`
H2_LOG_FILE=$H2_DIR/h2.log
H2_PID_FILE=$H2_DIR/h2.pid
BISTOURY_TMP_DIR="/tmp/bistoury"
H2_PORT_FILE="$BISTOURY_TMP_DIR/h2port.conf"

H2_DATA_BASE_URL="/tmp/bistoury/h2/bistoury;MODE=MYSQL;TRACE_LEVEL_SYSTEM_OUT=2;AUTO_SERVER=TRUE;"
APP_LOG_DIR="\/tmp"

. "bistoury-application-env.sh"

H2_PORT=9092;
echo "$H2_PORT">$H2_PORT_FILE

for CMD in "$@";do true; done

while getopts i:j:l:h opt;do
    case $opt in
        i) PASS_HOSTIP=$OPTARG;;
        j) JAVA_HOME=$OPTARG;;
        l) APP_LOG_DIR=$OPTARG;;
        h|*) echo "-i    通过-i指定本机ip"
           echo "-j    通过-j指定java home"
           echo "-l    通过-l指定应用日志目录"
           echo "-h    通过-h查看命令帮助"
           exit 0
    esac
done

if [[ "$JAVA_HOME" != "" ]];then
    JAVA="$JAVA_HOME/bin/java"
else
    JAVA=/usr/local/java/default;
fi

start(){

    echo "Init tables"
    $JAVA -cp h2-1.4.199.jar org.h2.tools.RunScript -url "jdbc:h2:file:$H2_DATA_BASE_URL" -script ./schema.sql

    echo "Init datas"
    #替换数据库初始化文件中的sql
    APP_LOG_DIR=` echo $APP_LOG_DIR | sed 's#\/#\\\/#g'`
    sed 's/${agent_hostip}/'$AGENT_HOSTIP'/g' data.sql | sed 's/${agent_hostname}/'$AGENT_HOSTNAME'/g'|sed 's/${log_dir}/'$APP_LOG_DIR'/g' >newdata.sql

    $JAVA -cp h2-1.4.199.jar org.h2.tools.RunScript -url "jdbc:h2:file:$H2_DATA_BASE_URL" -script ./newdata.sql

    rm -rf newdata.sql

    echo "Start h2 database"
    nohup $JAVA -cp h2*.jar org.h2.tools.Server  -tcp -tcpPort $H2_PORT -tcpAllowOthers -ifNotExists> "$H2_LOG_FILE" 2>&1 < /dev/null &

    if [[ $? -eq 0 ]]
    then
      /bin/echo -n $! > "$H2_PID_FILE"
      if [[ $? -eq 0 ]];
      then
        sleep 1
        echo STARTED
      else
        echo FAILED TO WRITE PID
        exit 1
      fi
    else
      echo SERVER DID NOT START
      exit 1
    fi
}
stop(){
    echo "Stopping h2 database ... "
    if [[ ! -f "$H2_PID_FILE" ]]
    then
      echo "no h2 database to stop (could not find file $H2_PID_FILE)"
    else
      kill $(cat "$H2_PID_FILE")
      rm "$H2_PID_FILE"
      rm "$H2_PORT_FILE"
      echo "STOPPED"
    fi
}
if [[ "start" == $CMD ]]; then
    start
elif [[ "stop" == $CMD ]]; then
    stop
else
    echo "命令格式错误，Usage: [$0 -j java_home start] or [$0 stop]"
    exit 0
fi