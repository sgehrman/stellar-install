#bash


echo "Stopping Services..."

systemctl stop stellar-core
systemctl stop horizon
systemctl stop stellar-core-testnet
systemctl stop horizon-testnet

# remove the symlinks in multi-user.target.wants
systemctl disable stellar-core
systemctl disable horizon
systemctl disable stellar-core-testnet
systemctl disable horizon-testnet

# not sure if needed, but might avoid some failures on delete
sleep 3

echo "Installing..."

# config files stored here, deleting directory
rm -r /etc/stellar/
mkdir /etc/stellar/
chown stellar /etc/stellar/

# buckets and logs stored here
rm -r /var/stellar
mkdir /var/stellar
chown stellar /var/stellar

mkdir /var/stellar/buckets-testnet
chown stellar /var/stellar/buckets-testnet

mkdir /var/stellar/buckets
chown stellar /var/stellar/buckets

mkdir /var/stellar/log
chown stellar /var/stellar/log

# ---------------
# configs
cp ./config-files/stellar-core.cfg /etc/stellar/stellar-core.cfg
cp ./config-files/stellar-core-testnet.cfg /etc/stellar/stellar-core-testnet.cfg

# ---------------
# horizon
rm /lib/systemd/system/horizon.service
rm /lib/systemd/system/horizon-testnet.service

cp ./config-files/horizon.service /lib/systemd/system/horizon.service
cp ./config-files/horizon-testnet.service /lib/systemd/system/horizon-testnet.service

# ---------------
# stellar-core
rm /lib/systemd/system/stellar-core.service
rm /lib/systemd/system/stellar-core-testnet.service

cp ./config-files/stellar-core.service /lib/systemd/system/stellar-core.service
cp ./config-files/stellar-core-testnet.service /lib/systemd/system/stellar-core-testnet.service

# reload updated files
systemctl daemon-reload
