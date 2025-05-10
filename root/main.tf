module "vpc" {
  source          = "../modules/vpc"
  region          = var.region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2b_cidr = var.pub_sub_2b_cidr
  pri_sub_3a_cidr = var.pri_sub_3a_cidr
  pri_sub_4b_cidr = var.pri_sub_4b_cidr
  pri_sub_5a_cidr = var.pri_sub_5a_cidr
  pri_sub_6b_cidr = var.pri_sub_6b_cidr
}

module "security-group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
}

# creating Key for instances
module "key" {
  source = "../modules/key"
}

module "ec2" {
  source = "../modules/ec2"
  vpc_id = module.vpc.vpc_id
  ami = var.ami
  instance_type = var.instance_type
  key_name = module.key.key_name
  subnet_id = module.vpc.pub_sub_1a_id
  instance_name = var.instance_name
  vpc_security_group_ids = [module.security-group.ec2_sg_id]
  availability_zone = module.vpc.az
}

module "ebs" {
  source = "../modules/ebs"
  instance_id = module.ec2.instance_id
  size = var.ebs_size
  az = module.vpc.az
}