# Misc
aws_region = "eu-west-1"

# Instance
aws_ami_id = "ami-07042e91d04b1c30d"
aws_instance_type = "t2.micro"
aws_root_volume_size = 20
aws_instance_key_name = "icecast-key"
aws_instance_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+WUNQTkJzOWr2IqH3vrVXUBMH3aBeiYSCUNvrPKHti98HDCeZ1QNEYQmy28ZNUHTocZRQy39ND/hIwPa4QI+F+YZVf6obQr1fYxdEqfPZvUu2/TP30+v7jWoWpAbHpAqnz57VaVeqdMrfzGoT4boMQzX14eZC5612geL9moy36fRrdtt5ycBRY8B2G8CwBu8XaYtb8yxlb0pzC8JGE7yLd4nyyZHMe1jJlhwnIZQ2jDZpao2WOcG+1CO2Zi5PQyK/qT/7hXqgVEk+Qd+a27VFoI3DHrL7PIQazBHPctbx8ZyAWwLrzWJr2+fFn3I1UKl2Z4V33/oHyTFQ5bDOF0XP icecast"

# VPC / Subnet
aws_vpc_cdir_block = "172.16.0.0/16"
aws_subnet_cdir_block = "172.16.10.0/24"
aws_subnet_az = "eu-west-1b"

# SGs
aws_my_ip = "93.176.147.135"
aws_icecast_source_port = 4040