#sudo useradd --system --home /etc/vault.d -m -U vault
#sudo passwd vault

echo "Downloading the vault binaries."
wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
sudo chown root:root vault
sudo mv vault /usr/local/bin/
vault --version

echo "Installing vault autocomplete."
vault -autocomplete-install
complete -C /usr/local/bin/vault vault

sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
sudo touch /etc/systemd/system/vault.service

sudo mkdir --parents /etc/vault.d
sudo touch /etc/vault.d/vault.hcl

sudo vi /etc/vault.d/vault.hcl

sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl

FQDN_HOST_NAME=$(hostname -f)
export VAULT_ADDR=http://$FQDN_HOST_NAME:8200

echo "Initializing vault in keys.txt"
vault operator init >> keys.txt

echo "Unsealing the vault for $VAULT_ADDR"
for i in `cat keys.txt | grep "Unseal Key " | awk '{print $4}'` ;
        do vault operator unseal $i ;
done
echo "Unsealing completed"



