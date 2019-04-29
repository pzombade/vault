# vault
HashiCorp Vault Deployment

An attempt to install HashiCorp Vault with https://labs.play-with-docker.com
1. Login into https://labs.play-with-docker.com and hit "Add a new instance".
2. In the new Docker shell clone this repository. (put clonde command here)
3. Give executable permissins to installation.sh
   chmod 755 installation.sh
4. Start the installation with following command:
   ./installation.sh
   
   
   Pending Items
   1. Create vault service during start-up.
   2. Unseal the Vault on start-up.
   3. Write spring boot code that wrap the Vault.
   4. Spring boot delegates the request/response to Vault.
   
   
