provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.aws_vpc_cdir_block
  enable_dns_hostnames = true

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.aws_subnet_cdir_block
  availability_zone = var.aws_subnet_az

  tags = {
    Name = "my_subnet"
  }
}

resource "aws_key_pair" "my_key" {
    key_name = var.aws_instance_key_name
    public_key = var.aws_instance_key
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

data "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "igw" {
  route_table_id = data.aws_route_table.my_route_table.id
  gateway_id = aws_internet_gateway.my_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_security_group" "icecast_sg" {
  name        = "IcecastSG"
  description = "Security Group for Icecast"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow SSH only to me"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.aws_my_ip}/32"]
  }

  ingress {
    description = "Allow Icecast2 source streams"
    from_port   = var.aws_icecast_source_port
    to_port     = var.aws_icecast_source_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "IcecastSG"
  }
}

resource "aws_eip" "icecast_eip" {
  vpc      = true
  instance = aws_instance.icecast.id

  tags = {
    Name = "IcecastEIP"
  }
}

resource "aws_instance" "icecast" {
  #ami = data.aws_ami.ubuntu.id
  ami = var.aws_ami_id
  instance_type = var.aws_instance_type
  key_name = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  subnet_id = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.icecast_sg.id]

  tags = {
    Name = "Icecast Streaming Server"
  }
}
