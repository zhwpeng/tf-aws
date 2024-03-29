resource "aws_instance" "bastion-instance" {
  ami           = var.instance-ami
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 100 
  }

  subnet_id = aws_subnet.public-subnet.id

  vpc_security_group_ids = [aws_security_group.allow-ssh-public.id]

  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name = "bastion-instance"
  }
}

resource "aws_instance" "private-instance" {
  ami           = var.instance-ami
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 100 
  }

  subnet_id = aws_subnet.private-subnet.id

  vpc_security_group_ids = [aws_security_group.allow-ssh-private.id]

  key_name = aws_key_pair.mykeypair.key_name
  
  tags = {
    Name = "private-instance"
  }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.key_path)
}
