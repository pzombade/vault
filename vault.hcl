
#Vault Configuration

ui=true

api_addr = "http://10.133.186.27:8200"
cluster_addr = "https://10.133.186.27:8201"

storage "file"{
path = "/etc/vault.d/vault_storage"
}

listener "tcp" {
   cluster_address  = "10.133.186.27:8201"
   address     = "0.0.0.0:8200"
   tls_disable = 1
}

path "sys/mounts/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "sys/mounts" {
  capabilities = [ "read", "list" ]
}

path "pki*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

