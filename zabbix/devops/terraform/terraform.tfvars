terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in S3
  remote_state = {
    backend = "s3"
    config {
      encrypt = true
      bucket = "${get_aws_account_id()}-terraform-remote-state-storage"
      key = "${path_relative_to_include()}/clouwatch-zabbix/terraform.tfstate"
      region = "us-west-2"
      dynamodb_table = "terraform_locks"
    }
  }

  terraform {
    # Force Terraform to keep trying to acquire a lock for up to 20 minutes
    # if someone else already has the lock.
    extra_arguments "retry_lock" {
      commands = [
        "init",
        "apply",
        "refresh",
        "import",
        "plan",
        "taint",
        "untaint"
      ]

      arguments = [
        "-lock-timeout=20m"
      ]
    }

    # Force Terraform to keep trying to acquire a lock for up to 20 minutes
    # if someone else already has the lock.
    extra_arguments "auto_approve" {
      commands = [
        "apply"
      ]

      arguments = [
        "-auto-approve"
      ]
    }
  }
}