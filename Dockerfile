FROM hashicorp/terraform:1.1.4
WORKDIR /root
COPY . .
WORKDIR /root/aws

# docker build -t storage-tf-module .
# docker run -d -t --name storage-tf-module --entrypoint /bin/sh storage-tf-module
# docker exec -ti storage-tf-module sh
