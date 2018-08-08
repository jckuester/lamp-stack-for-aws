terragrunt = {
  terraform {
    source = "git@github.com:cloudetc/terraform-modules.git//database?ref=v0.0.3"
  }

  dependencies {
    paths = ["../vpc"]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}