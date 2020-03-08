terragrunt = {
  terraform {
    source = "../../configuration//cloudwatch-alerts"

    extra_arguments "common-variables" {
      arguments = [
        "-var-file=../common.tfvars",
        "-var-file=../dev.tfvars"
      ]
      commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh",
        "destroy"
      ]
    }
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}