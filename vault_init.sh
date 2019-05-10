INITIALIZED=$(vault status | grep "Initialized" | awk '{print $2}')
echo "Vault cluster status is: $INITIALIZED"

if [ "$INITIALIZED" == "true" ]; then
    echo "Already initialized .. make GRPC/REST call to fetch the keys"
else
    echo "First instance of the cluster. Initializing vault in keys.txt"
	vault operator init >> keys.txt

	echo "Sleeping for 10 seconds..."
	sleep 10s

	echo "Unsealing the vault for $VAULT_ADDR"
	for i in `cat keys.txt | grep "Unseal Key " | awk '{print $4}'` ;
		do vault operator unseal $i ;
	done
	echo "Unsealing completed"
fi