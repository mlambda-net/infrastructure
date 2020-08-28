#!/bin/bash

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

source ./scripts/aws_deploy.sh


case $1 in
  deploy)
    case $2 in
      dev)
        echo "Releasing dev environment"
        deploy_aws "env/dev.tfvars" -var=env=dev
        ;;
      stg)
        ;;
      prod)
        ;;
    esac
    ;;
  delete)
    case $2 in
      dev)
        echo "Releasing dev environment"
        delete_aws "env/dev.tfvars" -var=env=dev
        ;;
      stg)
        ;;
      prod)
        ;;
    esac
    ;;
esac

