echo "Disabling unattended upgrades"

cat > /etc/apt/apt.conf.d/51disable-unattended-upgrades << EOF
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

export DEBIAN_FRONTEND="noninteractive"

apt-get update -qq > /dev/null
apt-get dist-upgrade -qq -y > /dev/null

apt-get install -qq -y --no-install-recommends libpam-systemd

apt -y update && apt-get -y upgrade
apt -y install software-properties-common apt-transport-https

echo "Do actions here"

