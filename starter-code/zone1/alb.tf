module "project_alb" {
  source            = "./modules/alb"
  instances_ids     = module.project_ec2.aws_instance[*].id
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}