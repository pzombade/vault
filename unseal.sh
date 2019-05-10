FQDN_HOST_NAME=$(hostname -f)
export VAULT_ADDR=http://$FQDN_HOST_NAME:8200
echo "Unsealing the vault for $VAULT_ADDR"
for i in `cat keys.txt | grep "Unseal Key " | awk '{print $4}'` ;
        do vault operator unseal $i ;
done
echo "Unsealing completed"


