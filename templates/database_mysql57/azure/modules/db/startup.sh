#!/bin/bash
# user_data scripts automatically execute as root user, 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

# Install docker community edition
apt-cache policy docker-ce
apt-get install -y docker-ce

# Pull MySQL image
docker pull ${mysql_image_name}

# Run container with port mapping
docker run -d \
    --name ${mysql_container_name} \
    -p ${mysql_container_port}:3306 \
    -e MYSQL_ROOT_PASSWORD=${mysql_root_password} \
    -e MYSQL_USER=${mysql_user_name} \
    -e MYSQL_PASSWORD=${mysql_user_password} \
    -e MYSQL_DATABASE=${mysql_database_name} \
    ${mysql_image_name}