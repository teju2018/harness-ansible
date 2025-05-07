resource "tls_private_key" "my_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "instance" {
  name         = "instance-1"
  machine_type = "e2-standard-2"

  boot_disk {
    initialize_params {
      image = "centos-stream-9"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "root:${tls_private_key.my_ssh_key.public_key_openssh}"
  }
}

output "private_key" {
  value     = tls_private_key.my_ssh_key.private_key_pem
  sensitive = true
}
