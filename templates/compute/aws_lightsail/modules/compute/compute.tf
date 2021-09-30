# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance
resource "aws_lightsail_instance" "test" {
  name              = "instance-test"
  availability_zone = "ap-northeast-1a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"
  # key_pair_name     = "my_key_pair"
  # user_data         = "${file("userdata.sh")}" 
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