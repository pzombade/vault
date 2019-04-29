mkdir /etc/vault.d
sudo cp vault.hcl /etc/vault.d
IPD="Dynamic"
echo "The IPD add is $IPD"
sed "s/IP_ADDRESS/$IPD/g" vault.hcl

sudo mv vault.service /etc/systemd/system
sudo mkdir -p /etc/vault.d/vault_storage


wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
sudo chown root:root vault
sudo mv vault /usr/local/bin/
vault --version
#vault -autocomplete-install
#complete -C /usr/local/bin/vault vault
#sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
#sudo useradd --system --home /etc/vault.d --shell /bin/false vault

#sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl
vault server -config=/etc/vault.d/vault.hcl