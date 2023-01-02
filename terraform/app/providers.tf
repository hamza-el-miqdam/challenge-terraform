provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      "Challenge" = true
      "Source"     = "main-tf"
    }
  }
}