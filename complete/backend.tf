terraform {

  required_version = " >= 0.12"
  backend "s3" {
    encrypt = true
    bucket  = "final-3tier-tf-state"
    region  = "us-west-1"
    key     = "terraform/state/fianlstate.tfstate"
  }
}