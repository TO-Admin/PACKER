provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "web_server" {
  name        = "tp-packer"
  description = "Allow HTTP and SSH"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = ""
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_server.id]
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
