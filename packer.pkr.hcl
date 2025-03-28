source "amazon-ebs" "tp-packer" {
  ami_name           = "tp-packer"
  region             = "eu-west-1"
  source_ami         = "ami-08f9a9c699d2ab3f9"
  instance_type      = "t2.micro"
  ssh_username       = "ec2-user"
  associate_public_ip_address = true
}

build {
  sources = ["source.amazon-ebs.tp-packer"]
  provisioner "ansible" {
    playbook_file = "playbook.yml"
    user = "ec2-user"
    use_sftp = true
    sftp_command = "/usr/libexec/openssh/sftp-server -e"
  }
}

