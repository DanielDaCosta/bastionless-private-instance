# Bastion-less: Accessing Private Ec2 instance with Session Manager

In this repository we'll set up a Private EC2 instance (in a private subnet), and use SSM session manager to access the instance and access a Jupyter Notebook server using PostFowarding for AWS Sytems Manger.

Session Manager provides secure instance management without opening *inbound ports* or setting up *bastion hosts* or *managing the SSH keys*.

# Introduction

It is well known that we connot directly connect to a private ec2 instance unless there is VPN Connectivity or Direct Connect or other network connectivity source with the VPC. A common approach to connect to a EC2 intance on a private subnet of your VPC is to use a **Bastion Host**.

A **Bastion Host** is a server whose purpose is to provide access to a private network from a external network (such as: the Internet). Because of its exposure to potential attack, a bastion host must minimize the chances of penetrations. When using a bastion host, you log into the bastion host first, and then into your target private instance. With this approach only the bastion host will have an external IP address.

The bastion host also has a cost associated with it as it is a running EC2 instance. Even a t2.micro costs about $10/month.

Howerver there are some drawbacks:

- You will need to allow SSH inbound rule at your bastion
- You need to open ports on yout private EC2 instance in order to connect it to your bastion
- You will need to manage SSH key credentials of your users: You will need to generate a ssh key pair for each user or get a copy of the same SSH key for your users
- Cost: The bastion host also has a cost associated with it as it is a running EC2 instance. Even a t2.micro costs about $10/month.

[IMAGE]

**Session Manager** can be used to access instances within private subnets that allow no ingress from the internet. AWS SSM provides the ability to establish a shell on your systems through its native service, or by using it as a tunnel for other protocols, such as Secure Shell (SSH). Advantages:

- It will log the commands issued during the session, as well as the results. You can save the logs in s3 if you wish.
- Shell access is completely contained within Identity and Access Management (IAM) policies, you won't need to manage SSH keys
- The user does not need to use bastion host and Public IPs.
- No need to open the ports in the security groups

[IMAGE]

# Folder Structure
```
.
|-- Images
|-- LICENSE
|-- README.md
|-- data.tf
|-- ec2_private.tf
|-- iam.tf
|-- main.tf
|-- network
|   |-- elastic_ip.tf
|   |-- main.tf
|   |-- route_table.tf
|   |-- subnets.tf
|   |-- terraform.tfvars
|   `-- variables.tf
|-- policies
|   `-- session-manager.json
|-- security_group.tf
|-- variables.tf
`-- variables.tfvars
```
# Prerequisites


# References
- https://aws.amazon.com/blogs/security/how-to-record-ssh-sessions-established-through-a-bastion-host/
- https://www.1cloudhub.com/connect-ec2-private-instance-using-session-manager-go-bastion-less/
- https://www.netskope.com/blog/leaving-bastion-hosts-behind-part-2-aws