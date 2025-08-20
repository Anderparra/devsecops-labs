# DEMO ONLY: Intentionally insecure Security Group to trigger IaC scanners.
# Do NOT apply in real environments.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "demo_insecure_ssh" {
  name        = "demo-insecure-ssh"
  description = "DEMO: Insecure SG for scanning - DO NOT USE IN PROD"

  ingress {
    description = "SSH open to the world (demo)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Purpose = "DevSecOps-Scanning-Demo"
  }
}
