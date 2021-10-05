# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance
resource "aws_lightsail_instance" "test" {
  name              = "instance-test"
  availability_zone = "ap-northeast-1a"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_0"
  # key_pair_name     = "my_key_pair"
  user_data         = templatefile("./modules/db/startup.sh", {
    mysql_image_name = var.mysql_image_name
    mysql_container_port = var.mysql_container_port
    mysql_container_name = var.mysql_container_name
    mysql_root_password = var.mysql_root_password
    mysql_user_name = var.mysql_user_name
    mysql_user_password = var.mysql_user_password
    mysql_database_name = var.mysql_database_name
  })

  tags = {
    env = "test"
  }

  connection {
    type        = "ssh"
    host        = "${self.public_ip_address}"
    # private_key = "${file("my_key.pem")}"
    user        = "user"
    timeout     = "20s"
  }
}

resource "aws_lightsail_instance_public_ports" "test" {
  instance_name = aws_lightsail_instance.test.name

  port_info {
    protocol  = "icmp"
    from_port = 8
    to_port   = 0
  }

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }
}