variable "region" {
  default = "eu-central-1"
}

variable "app_name" {
  default = "JenkinsDeploy"
}


#---------------------------------------------------------



provider "aws" {
  region = var.region
}

resource "aws_elastic_beanstalk_application" "JenkinsDeploy" {
  name        = var.app_name
  description = "This is part of Jenkins CI/CD pipeline"
}

resource "aws_elastic_beanstalk_environment" "JenkinsDeploy-env" {
  name                = "${var.app_name}-env"
  application         = aws_elastic_beanstalk_application.JenkinsDeploy.name
  solution_stack_name = "64bit Amazon Linux 2 v3.7.2 running Python 3.8"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-ec2+elacticbeanstalk-service-role"
  }
}
