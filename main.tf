provider "aws" {
    region = "af-south-1"
}

resource "aws_vpc" "foxapp-vpc" {
    cidr_block = var.vpc_cidr_blocks
    tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "foxapp-subnet" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.foxapp-vpc.id
    default_route_table_id = aws_vpc.foxaapp-vpc.default_route_table_id
}

module "foxapp-server" {
    source = "./modules/webserver"
    vpc_id = aws_vpc.foxapp-vpc.id
    my_ip = var.my_app
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    instance_type = var.instance_type
    subnet_id = module.foxapp-subnet.subnet.id
    avail_zone = var.avail_zone
}