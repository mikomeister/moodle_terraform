provider "aws" {
  version = "= 3.16.0"
  region  = var.region
}

provider "local" {
  version = "= 1.3.0"
}

provider "null" {
  version = "= 2.1.2"
}

provider "template" {
  version = "=  2.1.2"
}
