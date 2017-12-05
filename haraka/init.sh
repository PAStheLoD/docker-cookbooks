#!/bin/bash

cd /usr/local/haraka

if [[ ${relay_from_cidr} != "" ]] ; then
    for prefix in $(echo ${relay_from_cidr} | tr ',' ' ') ; do
        echo Relay enabled from: ${prefix}
        echo ${prefix} >> config/relay_acl_allow
    done

    echo "relay" >> config/plugins
fi

if [[ "${auth_user}" != "" ]] && [[ "${auth_password}" != "" ]] ; then
    echo "
    [core]
    methods=PLAIN,LOGIN,CRAM-MD5
    [users]
    ${auth_user}=${auth_password}
    " > config/auth_flat_file.ini
else
    if [[ "${auth_user}" != "" ]] && [[ "${auth_password}" = "" ]] ; then
        echo "ERROR: Auth settings make no sense, auth_password env var missing"
        exit 1
    fi
    if [[ "${auth_user}" = "" ]] && [[ "${auth_password}" != "" ]] ; then
        echo "ERROR: Auth settings make no sense, auth_user env var missing"
        exit 1
    fi
fi

if [[ ${tls_key} != "" ]] && [[ ${tls_cert} != "" ]] ; then
    echo "tls" >> config/plugins

    echo "
    key=$tls_key
    cert=$tls_cert
    " > config/tls.ini
    echo "Enabled TLS with key=$tls_key and cert=$tls_cert"
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

