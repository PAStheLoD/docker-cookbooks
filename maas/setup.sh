export DEBIAN_FRONTEND=noninteractive

apt-get -qq update
apt-get install -y sudo systemd vim bash-completion

# Don't start any optional services except for the few we need.
find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

systemctl set-default multi-user.target

apt-get install -y maas
apt-get clean

systemctl stop postgresql

mkdir -p /___init_data
mv /var/lib/postgresql /___init_data/

echo '
[Install]
RequiredBy=postgresql.service

[Service]
After=local-fs.target
Before=postgresql.service
Type=oneshot
ConditionPathIsMountPoint=/var/lib/postgresql
ConditionPathExists=/___init_data/postgresql
ConditionDirectoryNotEmpty=!/var/lib/postgresql
ExecStart=/bin/bash -c "IFS=\n ; for i in $(find /___init_data/postgresql/ -mindepth 1 -maxdepth 1 -type d) ; do [[ ! -e "/var/lib/postgresql/$(basename $i)" ]] && mv "$i" /var/lib/postgresql/ ; done ; chown -R postgres /var/lib/postgresql ; rmdir /___init_data/postgresql ; rmdir --ignore-fail-on-non-empty /___init_data"
' > /etc/systemd/system/postgresql-prepare_db.service

systemctl enable postgresql-prepare_db.service
