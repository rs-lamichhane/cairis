#!/bin/bash

export CAIRIS_SRC=/cairis/cairis
export PYTHONPATH=/cairis
export CAIRIS_CFG=/cairis.cnf

USERNAME=$1

python3 $CAIRIS_SRC/bin/rm_cairis_user.py $USERNAME
