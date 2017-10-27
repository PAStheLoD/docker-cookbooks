#!/bin/bash

cd /usr/local/haraka

if [[ ${relay_from_cidr} != "" ]] ; then
    echo Relay enabled from: ${relay_from_cidr}
    echo ${relay_from_cidr} > config/relay_acl_allow

    echo "relay" >> config/plugins
fi

if [[ ${log_timestamps} != "" ]] ; then
    sed -i -r "s/timestamps=false/timestamps=true/" config/log.ini
fi

if [[ ${acl} = "disable" ]] || [[ ${acl} = "disabled" ]] ; then
    sed -i -r "s/access/# access/g" config/plugins
fi

if [[ ${debug} != "" ]] ; then
    sed -i -r "s/level=.*/level=debug/g" config/log.ini
fi

exec haraka -c /usr/local/haraka 2>&1

