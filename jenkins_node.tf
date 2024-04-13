resource "aws_instance" "jenkins_node" {
  ami           = "ami-05c969369880fa2c2" # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.medium" # Set your desired instance type
  key_name      = "soham-key" # Set your key pair name
  security_groups = ["launch-wizard-1"] # Set your security group name

  tags = {
    Name = "jenkins_node"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y default-jre default-jdk
              EOF
}

output "public_ip" {
  value = aws_instance.jenkins_node.public_ip
}
