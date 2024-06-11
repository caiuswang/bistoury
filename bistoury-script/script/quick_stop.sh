#!/bin/bash
/usr/local/java/default/bin/jps -lm | grep bistoury | awk '{print $1}' | xargs kill -9
netstat -nlp | grep 9092 | awk '{print $7}' | awk -F"/" '{ print $1 }' | xargs kill -9
netstat -nlp | grep 9091 | awk '{print $7}' | awk -F"/" '{ print $1 }' | xargs kill -9
rm -rf /tmp/bistoury/h2
rm -rf bistoury-agent/logs
