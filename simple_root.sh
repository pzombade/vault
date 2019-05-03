wget https://releases.hashicorp.com/vault/1.1.1/vault_1.1.1_linux_amd64.zip
unzip vault_1.1.1_linux_amd64.zip
mv vault /usr/local/bin/
vault --version

mkdir --parents /etc/vault.d/vault_storage


IPD=$(hostname -i)
echo "The IPD add is $IPD"
sed -i "s/IP_ADDRESS/$IPD/g" vault.hcl
echo "Updated vault.hcl"

mv vault.hcl /etc/vault.d/vault.hcl

vault server -config=/etc/vault.d/vault.hcl &
vault operator init -recovery-shares=5 -recovery-threshold=2 >> keys.txt





