default["nginx"][:node_proxy][:http_port] = 8080
default["nginx"][:node_proxy][:https_port] = 44380
default["nginx"][:node_proxy][:wss_port] = 8080
default["nginx"][:node_proxy][:phpmyadmin_name] = ""

default["nginx"][:economy_node_proxy][:http_port] = 80
default["nginx"][:economy_node_proxy][:https_port] = 500
default["nginx"][:economy_node_proxy][:phpmyadmin_name] = ""
default["nginx"][:economy_node_proxy][:crt_path] = "/path/to/cert.crt"
default["nginx"][:economy_node_proxy][:key_path] = "/path/to/cert.key"
