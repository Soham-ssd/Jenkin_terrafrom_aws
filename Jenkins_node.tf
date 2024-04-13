resource "aws_instance" "jenkins_instance" {
  ami           = "ami-05c969369880fa2c2" # Ubuntu 20.04 LTS AMI ID
  instance_type = "t2.medium" # Set your desired instance type
  key_name      = "soham-key" # Set your key pair name
  security_groups = ["launch-wizard-1"] # Set your security group name

  tags = {
    Name = "jenkins_instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y default-jre default-jdk
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install -y jenkins
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF
}

output "public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}
