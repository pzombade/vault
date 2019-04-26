IPADD=$(hostname -i)
echo "The IPD add is $IPADD"
sed 's/IP_ADDRESS/$IPADD/g' vault.hcl
wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
sudo chown root:root vault
sudo mv vault /usr/local/bin/
vault --version
vault -autocomplete-install
complete -C /usr/local/bin/vault vault
#sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
#sudo useradd --system --home /etc/vault.d --shell /bin/false vault
sudo mv vault.service /etc/systemd/system
sudo mkdir -p /etc/vault.d/vault_storage
sudo mv vault.hcl /etc/vault.d
sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl
vault server -config=/etc/vault.d/vault.hcl