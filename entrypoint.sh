#!/bin/bash
ALGO="${ALGO:=kawpow}"
SERVER="${SERVER:=stratum+tcp://rvn.2miners.com:6060}"
USERNAME="${USERNAME:=RSVSQpK3QDgF3QVc5Q1togocAqD3Zy9FsB}"
PASSWORD="${PASSWORD:=x}"
WORKER_NAME="${WORKER_NAME:=nbminer}"
API_URL="${API_URL:=0.0.0.0}"
API_PORT="${API_PORT:=8000}"
EXTRA_ARGS="${EXTRA_ARGS}"

/usr/local/bin/nbminer -a $ALGO -o $SERVER -u $USERNAME.$WORKER_NAME -p $PASSWORD --api $API_URL:$API_PORT $TREX_EXTRA_ARGS
