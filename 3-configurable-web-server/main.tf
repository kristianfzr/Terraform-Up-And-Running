provider "aws" {
  region = "us-east-2" #"eu-west-1"
}

# EC2 Instance
resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0" #"ami-0f5b07b31937d4275"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "tttt"
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    "Name" = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}
output "server_port" {
  value       = var.server_port
  description = "Server Port"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

variable "server_port" {
  description = "The port the server will use for HTTP"
  type        = number
  default     = 8080
}