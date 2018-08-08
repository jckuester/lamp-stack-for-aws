terragrunt = {
  terraform {
    source = "git@github.com:cloudetc/terraform-modules.git//webserver?ref=v0.0.3"
  }

  dependencies {
    paths = ["../vpc", "../database"]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}