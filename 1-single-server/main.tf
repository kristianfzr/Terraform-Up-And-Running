provider "aws" {
  region = "eu-west-1"
}

# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-04d9ce6b8cf0f422c"
  instance_type = "t2.micro"

  tags = {
    "Name" = "terraform-example"
  }
}