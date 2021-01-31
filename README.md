# SPARK CLUSTER

This repository create a spark cluster on AWS or GCP using Terraform and Ansible.

## USING ON AWS

1. Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
2. Configure AWS credential with `aws configure`.
3. Go to `provision-aws-instance` folder.
4. Run `terraform init`.
5. Run `terraform plan/apply` setting these two variables:
    * local_cdirs: A list of CIDR blocks (IP's with permission of access spark cluster).
    * aws_ssh_key_name: Name of ssh-key on aws ec2. You can create on this [tutorial](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).


## USING ON GCP
1. Install [Goolge Cloud sdk](https://cloud.google.com/sdk/docs/install).
2. Authentication with `gcloud auth application-default login`.
3. Go to `provision-aws-instance` folder.
4. Run `terraform init`.
5. Run `terraform plan/apply`


## INSTALL SPARK
>UNDER CONSTRUCTION
1. Execute `ansible-playbook -i hosts main.yml` inside provision-spark folder