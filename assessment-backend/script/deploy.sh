#!/bin/sh

# Stop script on first error
set -e


# Decode SSH key
echo "${BACKEND_PRIVATE_KEY}" | base64 -d --ignore-garbage > ssh_key
chmod 600 ssh_key # private keys need to have strict permission to be accepted by SSH agent

# Add production server to known hosts
#echo "${BACKEND_PUBLIC_KEY}" | base64 -d --ignore-garbage >> ~/.ssh/known_hosts


echo "Deploying via remote SSH"
ssh -oStrictHostKeyChecking=no -i ssh_key "ec2-user@${SERVER_HOST_NAME}" \
  "aws ecr get-login-password --region eu-west-1 | sudo docker login --username AWS --password-stdin 256909349812.dkr.ecr.eu-west-1.amazonaws.com \
  && sudo docker stop live-container \
  && sudo docker container rm live-container \
  && sudo docker pull 256909349812.dkr.ecr.eu-west-1.amazonaws.com/appops-ionica-backend:ionicda001 \
  && sudo docker run --init -d --name live-container -p 80:4000 256909349812.dkr.ecr.eu-west-1.amazonaws.com/appops-ionica-backend:ionicda001 \
  && sudo docker system prune -af"
  

echo "Successfully deployed, hooray!"

# && sudo docker stop live-container \
# && sudo docker rm live-container \
