# Region
variable "region" {
  type = string
  default =  "us-east-2"
}

# Availability Zones
variable "azs" {
  type = list
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "keyname" {
  default = "mediawiki"
}

# Amazon Linux 2 [Free Tier]
variable "aws_ami" {
  default="ami-077e31c4939f6a2f3"
}

# VPC and Subnet
variable "aws_cidr_vpc" {
  default = "10.0.0.0/16"
}

variable "aws_cidr_subnet1" {
  default = "10.0.1.0/24"
}

variable "aws_cidr_subnet2" {
  default = "10.0.2.0/24"
}

variable "aws_sg" {
  default = "sg_mediawiki"
}

variable "aws_tags" {
  type = map
  default = {
    "webserver1" = "MediaWiki-Web-1"
	"webserver2" = "MediaWiki-Web-2"
    "dbserver" = "MediaWikiDB" 
  }
}

variable "aws_instance_type" {
  default = "t2.micro"
}
