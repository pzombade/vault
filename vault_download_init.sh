#sudo useradd --system --home /etc/vault.d -m -U vault
#sudo passwd vault

if [[ $# -eq 0 ]] ; then
    echo 'Please provide etcd host deatils.'
    exit 0
fi

if [ ! -f /opt/bmc/vault_1.1.1_linux_amd64.zip ]; then
	echo "Downloading the vault binaries."
	wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
	mv vault_1.1.1_linux_amd64.zip /opt/bmc
else
	echo "Vault zip found skipping the download."
fi

unzip /opt/bmc/vault_1.1.1_linux_amd64.zip
sudo chown root:root /opt/bmc/vault
sudo mv /opt/bmc/vault /usr/local/bin/
vault --version

#echo "Installing vault autocomplete."
#vault -autocomplete-install
#complete -C /usr/local/bin/vault vault

sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
sudo cp vault.service /etc/systemd/system/vault.service

sudo mkdir --parents /etc/vault.d
#!/bin/bash

HOST_FQDN_NAME=$(hostname -f)
export VAULT_ADDR=http://$HOST_FQDN_NAME:8200
UUID=$(uuidgen)

echo "UUID is $UUID"
echo "The IPD add is $1"
sed -i "s/IP_ADDRESS/$1/g" vault.hcl
echo "ETCD host 1: $2"
echo "ETCD host 2: $3"
sed -i "s/ETCD_HOST_1/$2/g" vault.hcl
sed -i "s/ETCD_HOST_2/$3/g" vault.hcl
sed -i "s/UUID_PATH/$UUID/g" vault.hcl
echo "Updated vault.hcl"

sudo cp vault.hcl /etc/vault.d/vault.hcl

sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl


sudo systemctl enable vault
sudo systemctl start vault

echo "Sleeping for 15 seconds. So that vault can start successfully."
sleep 15s

STATUS=$(vault status)
echo "Vault status is $STATUS"




