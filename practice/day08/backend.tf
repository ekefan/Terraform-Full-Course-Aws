terraform {
  backend "s3" {
    bucket       = "terraform-state-1764672253"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-3"
    use_lockfile = true
    encrypt      = true
    profile      = "friction-eben-cli"
  }
}
