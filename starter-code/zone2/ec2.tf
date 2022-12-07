#  module "project_ec2" {
#    source             = "./modules/ec2"
#    name               = local.name
#    account            = data.aws_caller_identity.current.account_id
#    aws_ami            = data.aws_ami.amazon_linux_2.id
#    private_subnet_ids = module.vpc.private_subnet_ids
#    vpc_id             = module.vpc.vpc_id
#  }

module "project_ec2" {
  source             = "./modules/ec2"
  instance_count     = var.instance_count
  name               = local.name
  account            = data.aws_caller_identity.current.account_id
  aws_ami            = "ami-0cd5de7d05a46dfc2"
  private_subnet_ids = data.terraform_remote_state.zone1.outputs.private_subnet_ids
  public_subnet_ids  = data.terraform_remote_state.zone1.outputs.public_subnet_ids
  vpc_id             = data.terraform_remote_state.zone1.outputs.vpc_id
}
