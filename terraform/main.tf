provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_instance" "nodejs_app" {
  ami           = "ami-08b5b3a93ed654d19" # Amazon Linux 2 AMI (change as needed)
  instance_type = "t2.micro"

  tags = {
    Name = "NodeJS-App"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nodejs
              sudo yum install -y git
              git clone https://github.com/deadmedusa/nodejs.git /home/ec2-user/app
              cd /home/ec2-user/app
              npm install
              npm start
              EOF

  vpc_security_group_ids = [aws_security_group.nodejs_sg.id]
}

resource "aws_security_group" "nodejs_sg" {
  name_prefix = "nodejs-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.nodejs_app.public_ip
}
