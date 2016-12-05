# Don't start any optional services except for the few we need.
find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

systemctl set-default multi-user.target

export DEBIAN_FRONTEND=noninteractive


apt-get -qq update
apt-get install -y sudo maas

systemctl stop postgresql

mkdir -p /___init_data
mv /var/lib/postgresql /___init_data/

echo '
[Service]
After=local-fs.target
Before=postgresql.service
Type=oneshot
ConditionPathExists=/___init_data/postgresql
ExecStart=/bin/bash -c "mkdir -p /var/lib/postgresql ; mv /___init_data/postgresql/* /var/lib/postgresql/ ; chown -R postgres /var/lib/postgresql ; rmdir --ignore-fail-on-non-empty /___init_data"
' > /etc/systemd/system/postgresql-prepare_db.service

systemctl enable postgresql-prepare_db.service
