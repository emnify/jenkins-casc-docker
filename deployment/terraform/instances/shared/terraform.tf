terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "prod-emnify-shared-terraform"
    dynamodb_table = "prod-emnify-shared-terraform"
    key            = "shared/prod/eu-west-1/jenkins-casc"
  }
}
