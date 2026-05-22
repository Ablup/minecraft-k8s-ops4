terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# Use the default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group: SSH and Minecraft
resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft-automation-sg"
  description = "Allow SSH and Minecraft traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Minecraft"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "minecraft_backups" {
  bucket = var.s3_bucket

  tags = {
    Name = "Minecraft World Backups"
  }
}

# EC2 Instance
resource "aws_instance" "minecraft_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  
  # Required for ECR and S3 access without hardcoded keys
  iam_instance_profile = "LabInstanceProfile"

  tags = {
    Name = "Minecraft-Automated"
  }
}
