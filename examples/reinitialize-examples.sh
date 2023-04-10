#!/bin/bash

EXAMPLES=(audit-log-config-datadog basic-aws basic-azure metrics-config-datadog)

# this script is designed to be executed from the root of ALL Workloads repositories

# iterate over Terraform Workspaces
for EXAMPLE in "${EXAMPLES[@]}" ; do

  # change into Workspace directory
  cd "examples/${EXAMPLE}" || exit

  # format code
  terraform fmt

  # if first argument is `lint`, skip non-linting operation
  if [ "${1}" != "lint" ];
  then
    # (re-)init Terraform codebase to fetch new and updates providers and modules
    terraform init -upgrade
  fi

  # render new version of `README.md`
  terraform-docs --config=file=../../.terraform-docs.yml .

  # change back into root directory
  cd ../..
done
