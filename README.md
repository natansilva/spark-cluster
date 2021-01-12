# SPARK CLUSTER

This repository create a spark cluster AWS or GCP using Terraform and Ansible.

## USING ON AWS

1. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
2. Configure AWS credential with `aws configure`.
2. Run `terraform plan/apply` on `provision-aws-instance` folder setting these two variables:
    * local_cdirs: A list of CIDR blocks (IP's with permission of access spark cluster).
    * aws_ssh_key_name: Name of ssh-key on aws ec2. You can create on this [tutorial](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).