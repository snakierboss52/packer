packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-22.04-jenkins"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-053b0d53c279acc90"
  ssh_username  = "ubuntu"

}

build {
  name = "packer-basic-configuraton-ubuntu"

  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get install -y ca-certificates curl gnupg"
    ]
  }

  provisioner "shell" {
    script = "dependencies.sh"
  }
}

