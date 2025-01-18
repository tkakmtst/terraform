// ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-${var.service_name}-ecs-task-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

// ECS Task Execution Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       =  aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

// ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.environment}-${var.service_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

// ECS Task Role Policy
resource "aws_iam_policy" "ecs_task_policy" {
  name = "${var.environment}-${var.service_name}-ecs-task-policy"
  description = "ECS task role policy to access S3, DynamoDB, etc."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource  = "${aws_cloudwatch_log_group.ecs.arn}"
      }
    ]
  })
}

// ECS Task Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ecs_task_role_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

// ECR Repository
resource "aws_ecr_repository" "main" {
  name = "${var.environment}-${var.service_name}-ecr-repo"

  image_scanning_configuration {
    scan_on_push = true
  }
}

// ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-${var.service_name}-cluster"
}

// CloudWatch Logs
resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/${var.environment}-${var.service_name}"
} 

// ECS Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.environment}-${var.service_name}-task-def"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "ENV"
          value = "${var.environment}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "nginx"
        }
      }
    }
  ])
}

// ECS Service
resource "aws_ecs_service" "main" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.security_group_id]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "app"
    container_port   = 80
  }
}
