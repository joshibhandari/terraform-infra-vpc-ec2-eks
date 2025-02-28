terraform{ 
 backend "s3" {
    bucket              = "terraform-backend-configuration"
    key                 = "terraform/state/test-infra/terraform.tfstate"
    region              = "us-east-1"
    # dynamodb_table      = "terraform_configuration"
    # encrypt                = true
  }
}