# nextcloud-terraform
📦 Set up NextCloud using Terraform

[Terraform](https://www.terraform.io/) is pretty rad, so is [Nextcloud](https://nextcloud.com/). Let's use one to set up the other.

This set of Terraform files eases the process of getting your own Nextcloud instance running from the ground up. All you need is to have your local `awscli` set up and hit `terraform apply` to get to business.

This instance of Nextcloud is ready to be set up to be backed by S3 ([with some manual steps](https://docs.nextcloud.com/server/19/admin_manual/configuration_files/external_storage/amazons3.html)) and leverages RDS to make your EC2 instance disposable if need be.

## Get started

### Prerequisites

- Make sure to have Terraform set up and ready to go ([see how to do this here](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- Make sure to have the AWS cli configured ([see how to do this here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html))

### Bringing your cloud up

- Populate the `secrets_template.tf` variables with appropriate values for your setup.
- `terraform apply`
- ...
- ✨ Run your own cloud ✨

### Contribute

Got some ideas or suggestions? They're welcome! Open an issue or submit a PR! I'm probably the main user of this setup, but anything to make it better is always welcome.
