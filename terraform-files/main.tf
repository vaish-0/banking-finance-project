resource "aws_instance" "test-server" {
  ami           = "ami-0e86e20dae9224db8" 
  instance_type = "t2.micro" 
  key_name = "linux-test"
  vpc_security_group_ids= ["sg-03e5b9761819bff37"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./linux-test.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Finance-me/terraform-files/ansibleplaybook.yml"
         }
  }
