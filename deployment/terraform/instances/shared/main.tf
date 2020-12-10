module "ecr" {
  source          = "git@github.com:emnify/tf-module-ecr-repository.git?ref=1.0.0"
  repository_name = "jenkins-casc"
}
