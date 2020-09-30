resource "upcloud_server" "prod01" {
  hostname = "prod01"

  zone = var.zones["amsterdam"]

  plan = var.plans["1CPU"]

  firewall = true

  storage_devices {
    size = lookup(var.storage_sizes, var.plans["1CPU"])

    storage = var.templates["ubuntu1604"]

    tier   = "maxiops"
    action = "clone"
  }

  network_interface {
    type = "public"
  }

  login {
    user = "root"
    keys = [ var.public_key[1] ]
    create_password = true
    password_delivery = "email"
  }

  connection {
    host        = self.network_interface.0.ip_address
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_key_file)
  }

  provisioner "file" {
    source      = "./installer.sh"
    destination = "/tmp/installer.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installer.sh",
      "/tmp/installer.sh",
    ]
  }
}

resource "upcloud_firewall_rules" "prod01" {
  server_id = upcloud_server.prod01.id

  firewall_rule {
    action = "accept"
    direction = "in"
    family = "IPv6"
    protocol = "tcp"
    source_address_end = "2a04:3540:53::1"
    source_address_start = "2a04:3540:53::1"
    source_port_end = "53"
    source_port_start = "53"
  }
  
  firewall_rule {
    action = "accept"
    direction = "in"
    family = "IPv6"
    protocol = "udp"
    source_address_end = "2a04:3540:53::1"
    source_address_start = "2a04:3540:53::1"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv6"
    protocol = "tcp"
    source_address_end = "2a04:3544:53::1"
    source_address_start = "2a04:3544:53::1"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv6"
    protocol = "udp"
    source_address_end = "2a04:3544:53::1"
    source_address_start = "2a04:3544:53::1"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv4"
    protocol = "udp"
    source_address_end = "94.237.127.9"
    source_address_start = "94.237.127.9"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv4"
    protocol = "tcp"
    source_address_end = "94.237.127.9"
    source_address_start = "94.237.127.9"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv4"
    protocol = "udp"
    source_address_end = "94.237.40.9"
    source_address_start = "94.237.40.9"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    direction = "in"
    family = "IPv4"
    protocol = "tcp"
    source_address_end = "94.237.40.9"
    source_address_start = "94.237.40.9"
    source_port_end = "53"
    source_port_start = "53"
  }

  firewall_rule  {
    action = "accept"
    comment = "user access to upcloud"
    direction = "in"
    family = "IPv4"
    protocol = "tcp"
    source_address_end = var.admin_ip["user"]
    source_address_start = var.admin_ip["user"]
  }

  firewall_rule  {
    action = "drop"
    direction = "out"
    family = "IPv4"
    protocol = "tcp"
  }

  firewall_rule  {
    action = "drop"
    direction = "in"
    family = "IPv4"
    protocol = "tcp"
  }
}

output "prod01_public_ip" {
    value = upcloud_server.prod01.network_interface.0.ip_address
}

output "prod01_hostname" {
    value = upcloud_server.prod01.hostname
}