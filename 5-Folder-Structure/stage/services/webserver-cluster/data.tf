data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "terraform-up-and-running-state-20210620"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
  }
}

data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  }
}