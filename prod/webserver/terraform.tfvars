terragrunt = {
  terraform {
    source = "git@github.com:cloudetc/terraform-modules.git//webserver?ref=v0.0.1"
  }

  dependencies {
    paths = ["../vpc", "../database"]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# overwrite default and use bigger instances in prod
#instance_type = "t2.large"