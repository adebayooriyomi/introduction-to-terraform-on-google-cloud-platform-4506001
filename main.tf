data "google_compute_subnetwork" "app" {
  name   = "app"
  region = "us-east1"
}

data "google_compute_image" "ubuntu" {
  most_recent = true
  project     = "ubuntu-os-cloud" 
  family      = "ubuntu-2204-lts"
}

resource "google_compute_instance" "web" {
  name         =  "web"
  machine_type = "e2-micro"

  
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
   subnetwork = "app"
   access_config {
      # Leave empty for dynamic public IP
    }
  }  

  allow_stopping_for_update = true
}
