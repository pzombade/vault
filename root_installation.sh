wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
chown root:root vault
mv vault /usr/local/bin/
vault --version
mv vault.service /etc/systemd/system/vault.service

mkdir --parents /etc/vault.d
mkdir /etc/vault.d/vault_storage
mv vault.hcl /etc/vault.d/vault.hcl
chmod 640 /etc/vault.d/vault.hcl

systemctl enable vault
systemctl start vault
export VAULT_ADDR=http://clm-pun-tlfq28.bmc.com:8200
vault operator init -recovery-shares=5 -recovery-threshold=2 >> keys.txt
echo "Done!"
