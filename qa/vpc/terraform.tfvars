terragrunt = {
  terraform {
    source = "git@github.com:cloudetc/terraform-modules.git//vpc?ref=v0.0.3"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

cidr = "10.0.0.0/24"
