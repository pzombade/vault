
#Vault Configuration

ui=true

api_addr = "http://IP_ADDRESS:8200"
cluster_addr = "https://IP_ADDRESS:8201"

storage "etcd" {
  address  = "http://ETCD_HOST_1:2380,http://ETCD_HOST_2:2380"
  etcd_api = "v3"
  path = "my-vault-data-5316f2bd-ce9c-4325-9e06-e9e315047af0/"
  ha_enabled    = "true"
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




