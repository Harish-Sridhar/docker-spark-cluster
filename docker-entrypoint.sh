#!/bin/bash

echo "This script is being executed..."

if [ "${SPARK_COMMAND}" = "help" ]
 then
    echo "Usage: $(basename "$0") (master|slave|help)"
    exit 0
elif [ "${SPARK_COMMAND}" = "master" ]
 then
  if [ -z "$SPARK_MASTER_HOST" ]
   then
      echo "SPARK_MASTER_HOST environemnt variable not set. Exiting."
      exit 1
  fi
    echo "Master instance to be started..."
    start-master.sh
    echo "Master instance started..."
    tail -f /usr/local/spark/logs/spark--org.apache.spark.deploy.master.*.out


elif [ "${SPARK_COMMAND}" = "slave" ]; then
    if [ -z "$SPARK_MASTER_URL" ]; then
      echo "SPARK_MASTER_URL environemnt variable not set. Exiting."
      exit 1
    fi
    echo "Master instance to be started..."
    start-slave.sh ${SPARK_MASTER_URL}
    echo "Slave instance started..."
    tail -f /usr/local/spark/logs/spark--org.apache.spark.deploy.worker.*.out
else
  echo "None of the loops running. please set the environement variable SPARK_COMMAND properly"
fi
