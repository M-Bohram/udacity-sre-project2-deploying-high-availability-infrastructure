module "project_alb" {
  source            = "./modules/alb"
  instances_ids     = module.project_ec2.aws_instance[*].id
  public_subnet_ids = data.terraform_remote_state.zone1.outputs.public_subnet_ids
  vpc_id            = data.terraform_remote_state.zone1.outputs.vpc_id
}
