resource "aws_instance" "New-test-server" {
  ami           = "ami-0c101f26f147fa7fd" 
  instance_type = "t2.micro" 
  key_name = "learnawskey"
  vpc_security_group_ids= ["sg-020a949c964fb36e9"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./learnawskey.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "New-test-server"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.New-test-server.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/terraform-files/ansibleplaybook.yml"
  }
  }
