terragrunt = {
  terraform {
    source = "git@github.com:cloudetc/terraform-modules.git//vpc?ref=v0.0.1"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}