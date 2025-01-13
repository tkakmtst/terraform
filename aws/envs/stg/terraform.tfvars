cidr_block                 = "10.0.0.0/16"
environment                = "stg"
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
availability_zones         = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
service_name               = "sample"
task_cpu                   = 256
task_memory                = 512
container_image            = "public.ecr.aws/nginx/nginx:latest"
container_cpu              = 256
container_memory           = 512
desired_count              = 1
domain_name                = "example.com"
api_subdomain_name         = "api.example.com"
acm_certificate_arn        = "arn:aws:acm:ap-northeast-1:account_id:certificate/hoge"
