
#Vault Configuration

ui=true

api_addr = "http://IP_ADDRESS:8200"
cluster_addr = "https://IP_ADDRESS:8201"

storage "file"{
path = "/etc/vault_storage"
}

listener "tcp" {
   cluster_address  = "IP_ADDRESS:8201"
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

