variable "aws_access_key_id" {
  description = "the aws access key id"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "the aws access secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "the aws access region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Name of the environment"
  type        = string
  default     = "dev"
}

variable "vpc_name" {
  description = "Name to be used on the Default VPC"
  type        = string
  default     = ""
}

variable "ssh_key_name" {
  type = string
  default = "connect"
}

variable "domain_name" {
  type = string
}

variable "cert_issuer" {
  type = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "private_domain" {
  type = string
}

variable "image_id" {
  type = string
  default = "ami-02354e95b39ca8dec"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_cidr" {
  description = "the CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = string
  default     = ""
}

variable "vpc_public_cidr" {
  description = "A list of public cidr inside the VPC"
  type        = string
  default     = ""
}

variable "vpc_private_cidr" {
  description = "A list of private cidr inside the VPC"
  type        = string
  default     = ""
}

