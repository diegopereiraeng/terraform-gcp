

// Configure the Google Cloud provider
provider "google" {
 credentials = file(var.gcp_sa) //
 project     = var.project //
 region      = var.region //"us-central1-a"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "diego-koala-vm-${random_id.instance_id.hex}"
 machine_type = var.instance_type // "f1-micro"
 zone         = var.region // "us-central1-a"
 ssh-keys = "INSERT_USERNAME:${file(var.ssh_keys)}"  // "~/.ssh/id_rsa.pub")}"
 
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure nodejs is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -y nodejs"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}


resource "google_compute_firewall" "default" {
 name    = "diego-app-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["3000"]
 }
}