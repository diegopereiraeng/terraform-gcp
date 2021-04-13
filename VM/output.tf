// A variable for extracting the external IP address of the instance
output "public_ip" {
    description = "List of public IP addresses assigned to the instances, if applicable"
    value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}