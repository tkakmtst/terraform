resource "aws_security_group" "pub_alb_sg" {
  name        = "${var.environment}-${var.service_name}-pub-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "${var.environment}-${var.service_name}-pub-alb-sg"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.environment}-${var.service_name}-ecs-sg"
  description = "Security group for ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.pub_alb_sg.id]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "${var.environment}-${var.service_name}-ecs-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-${var.service_name}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  tags = {
    Name = "${var.environment}-${var.service_name}-rds-sg"
  }
}
