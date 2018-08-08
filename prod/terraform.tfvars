terragrunt = {
  remote_state {
    backend = "s3"

    config {
      bucket = "terraform-state-xyz"
      key = "${path_relative_to_include()}/terraform.tfstate"
      region = "us-west-2"
      encrypt = true
      #dynamodb_table = "my-lock-table"
    }
  }

  terraform {
    extra_arguments "custom_vars" {
      commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh",
        "destroy"
      ]

      arguments = [
        "-var",
        "region=us-west-2",
        "-var",
        "environment=prod",
        "-var",
        "name=lamp",
        "-var",
        "tfstate_bucket=terraform-state-xyz",
        "-var",
        "profile=myaccount"
      ]
    }
  }
}