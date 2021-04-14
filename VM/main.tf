

// Configure the Google Cloud provider
provider "google" {
 credentials = var.gcp_sa //
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
 zone         = var.zone // "us-central1-a"
 metadata = {
   ssh-keys = "diego.pereira:${var.ssh_keys}"  // "~/.ssh/id_rsa.pub")}"
 }
 
 
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure nodejs is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -y nodejs;sudo apt-get install gnupg;sudo apt-get install -y git;sudo apt-get install -y npm;sudo npm install express;sudo npm install serve-favicon;sudo npm install morgan;sudo npm install fs;sudo npm install body-parser;sudo npm install method-override;sudo npm install errorhandler;sudo wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -;echo 'deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.4 main' | tee /etc/apt/sources.list.d/mongodb-org-4.4.list;sudo apt-get install -y mongodb-org"

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