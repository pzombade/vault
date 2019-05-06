#sudo useradd --system --home /etc/vault.d -m -U vault
#sudo passwd vault

if [[ $# -eq 0 ]] ; then
    echo 'Please provide etcd host deatils.'
    exit 0
fi

echo "Downloading the vault binaries."
wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
sudo chown root:root vault
sudo mv vault /usr/local/bin/
vault --version

#echo "Installing vault autocomplete."
#vault -autocomplete-install
#complete -C /usr/local/bin/vault vault

sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
sudo cp vault.service /etc/systemd/system/vault.service

sudo mkdir --parents /etc/vault.d
sudo touch /etc/vault.d/vault.hcl

UUID=$(uuidgen)
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

: '
HOST_FQDN_NAME=$(hostname -f)
export VAULT_ADDR=http://$HOST_FQDN_NAME:8200

echo "Initializing vault in keys.txt"
vault operator init >> keys.txt

echo "Unsealing the vault for $VAULT_ADDR"
for i in `cat keys.txt | grep "Unseal Key " | awk '{print $4}'` ;
        do vault operator unseal $i ;
done
echo "Unsealing completed"
'


