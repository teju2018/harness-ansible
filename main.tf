provider "google" {
    project = "sam-458313"
    zone = "us-west1-a"
  
}
locals {
PRIVATE_KEY = file("/root/.ssh/id_rsa")
PUBLIC_KEY = file("/root/.ssh/id_rsa.pub")
}
resource "google_compute_instance" "instance" {
    name= "instance-1"
    machine_type = "e2-standard-2"
    boot_disk {
      initialize_params {
        image = "centos-stream-9"
      }
    }
    network_interface {
      network = "default"
      access_config {
        
      }
    }
metadata = {
  ssh-keys = "root:${local.PUBLIC_KEY}"
}

  
}

output "vm_external_ip" {
  value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}
output "private_key" {
  value     = local.PRIVATE_KEY
  sensitive = true
}

