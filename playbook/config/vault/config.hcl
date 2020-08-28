#/etc/opt/vault/config.hcl
ui = true

api_addr = "http://127.0.0.1:80"

storage "file" {
  path = "/mnt/vault/data"
}

listener "tcp" {
  address = "0.0.0.0:80"
  tls_disable = 1
}
