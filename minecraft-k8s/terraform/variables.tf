variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Name of the existing SSH key pair in AWS"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu 24.04 AMI ID"
  type        = string
  default     = "ami-0a0e5d9c7acc336f1" # Verify this matches us-east-1
}

variable "s3_bucket" {
  description = "The unique name of the S3 bucket used for Minecraft world backups"
  type        = string
  default     = "cs312-gallupab-backups" 
}