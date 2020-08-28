#!/bin/bash

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.



deploy_aws () {
  pushd ./aws

  terraform init -input=false
  terraform plan -var-file=$1 $2 -out=./build/tfplan
  terraform apply -auto-approve build/tfplan

  popd
}


delete_aws() {
  pushd ./aws

  terraform init -input=false
  terraform plan -destroy -var-file=$1 $2 -out=./build/tfplan
  terraform apply -auto-approve build/tfplan

  popd
}