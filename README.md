# Sample code with Terraform modules for different Environments 

This structure is a showcase on how to use reusable terraform modules in order to create similar infrastructure for different environments (production/development etc).

## Infrastructure Details

This code creates an infrastructure following a similar scenario to [this](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html).
  - Creates a `VPC` with a `Public` and `Private Subnet`.
  - Creates an `Internet gateway` attached to the `Public Subnet`.
  - Creates a `NAT gateway` attached to the `Public Subnet` so that the `EC2 Instances` in the `Private `Subnet`` have internet access
  - Creates the relevant `Route tables` so that traffic from the `Public Subnet` is redirected to the `Internet gateway` and traffic from the `Private Subnet` is redirected to the `NAT Gateway`.
  - Creates an Ubuntu Server 18.04 AMD 64 `EC2 Instance` in the `Public Subnet` with relevant `Security Grous` that allow inbound traffic to port 8081 and port 22 from everywhere and outbound traffic to everywhere
  - Creates an Ubuntu Server 18.04 AMD 64 `EC2 Instance` in the `Private Subnet` with relevant `Security Grous` that allow inbound traffic to port 22 from the IP of the `EC2 Public Instance` (10.0.1.50) and outbound traffic to everywhere

# Pre start

## AWS configuration

Make sure that you have an `.aws` folder in your home directory with the `.aws/credentials` and `.aws.config` as per the [documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). This repo uses the `[default]` ones. You can change this in the respective variables.tf ([see above](#variables)). 

## Generate SSH keys

Generate keys for the two `EC2 Instances` in the environment/\*/keys folder. If you want to specify custon names, change the respective variables inside `environments/prod/variables.tf` and `environments/dev/variables.tf`.
```
# SSH keys for production environment (`ec2 public` & ec2 Private)
ssh_keygen -f environments/prod/keys/ec2_priv_rsa
ssh_keygen -f environments/prod/keys/ec2_pub_rsa

# SSH keys for development environment (`ec2 public` & ec2 Private)
ssh_keygen -f environments/dev/keys/ec2_priv_rsa
ssh_keygen -f environments/dev/keys/ec2_pub_rsa
```

# Code Structure

The code structure can be changed. For example you can move all the code from `environments/prod` and `environments/dev` one directory up since they are identical and declare `environment/prod` and `environment/dev` as modules. This is up to you.

The code follows this structure:
 - environments
   - prod
     - main.tf
     - variables.tf         # Contains variables for the production environment
     - outputs.tf           # Output from `terraform apply` to view some info about the created infrastructure
     - keys                 # Directory that contains ssh keys for the production environment's `EC2 Instances`
   - dev
     - main.tf
     - variables.tf         # Contains variables for the development environment
     - outputs.tf           # Output from `terraform apply` to view some info about the created infrastructure
     - keys                 # Directory that contains ssh keys for the development environment's `EC2 Instances`
  - modules
    - cluster               # Directory that contains all the config for the sample infrastructure
      - ami.tf              # AMI selection/creation configuration 
      - ec2.tf              # EC2 configuration
      - elastic-ip.tf       # Elastic IP configuration
      - gateways.tf         # Internet gateway & NAT gateway configuration
      - key-pairs.tf        # EC2 SSH keys configuration
      - outputs.tf          # Info output from the created infrastructure
      - route-tables.tf     # Route tables configuration
      - security-groups.tf  # `Security Grous` configuration
      - subnets.tf          # Subnets configuration
      - variables.tf        # Variable declaration for this module (no presets and defaults)
      - vpc.tf              # VPC configuration
  - scripts                 # Directory with useful scripts so that you can SSH to `EC2 Instances` later (see [below](#scripts) on how to use)

# Variables

You can change the preset variables inside `environments/prod/variables.tf` and `environments/dev/variables.tf` either by directly editing these files or by following [this](https://www.terraform.io/docs/configuration/variables.html).

For this sample project you can configura the following for each environment (respective `variables.tf`)
 - `profile`                  # The profile to be used (from `~/.aws/credetians` and `config` files) (default `default`)
 - `region`                   # Region to be used (default `us-east-1`)
 - `ec2_instance_type`        # The `EC2 instance` type for `EC2 public` and `EC2 Private` (default `t2.micro`)
 - `public_subnet_av_zone`    # Availability zone for public zubnet (default `us-east-1b`)
 - `private_subnet_av_zone`   # Availability zone for public zubnet (default `us-east-1c`)

For example you can change the variable of `ec2_instance_type` for production to something better (i.e `t2.medium`) and leave the default `t2.micro` for development since there are not much resources needed.

# Apply the environments on AWS

## Production
The following will create the production environment on AWS.
```
cd environments/prod
terraform init
terraform apply
# ...
# This will create the infrastructure for production environment and will
# output the public IP for the `EC2 public` and the elastic IP of the NAT gateway.
```

## Development
Similarly the following will create the development environment on AWS.  
```
cd environments/dev
terraform init
terraform apply
# ...
# This will create the infrastructure for development environment and will
# output the public IP for the `EC2 public` and the elastic IP of the NAT gateway.
```

# Scripts
There two main scripts in this directory

## ssh_public
Run this from the root directory of this project to ssh to the `EC2 Public Instance`.

This assumes that you have the generate SSH keys with the names provided in the [Generate SSH keys section](#generate-ssh-keys). If you have custom key names adjust the script to your needs.
```
# From production root directory (environments/prod)
../../scripts/ssh_public <PUBLIC-IP-OF-PUBLIC-INSTANCE>

# From development root directory (environments/dev)
../../scripts/ssh_public <PUBLIC-IP-OF-PUBLIC-INSTANCE>
```

## ssh_private
Run this from the root directory of this project to ssh to the `EC2 Private Instance` using the `EC2 Public Instance`.

This assumes that you have the generate SSH keys with the names provided in the [Generate SSH keys section](#generate-ssh-keys). If you have custom key names or you run Windows adjust the script to your needs.
```
# From production root directory (environments/prod)
../../scripts/ssh_private <PUBLIC-IP-OF-PUBLIC-INSTANCE>

# From development root directory (environments/dev)
../../scripts/ssh_private <PUBLIC-IP-OF-PUBLIC-INSTANCE>
```