## Background

Imagine you’re setting up AWS accounts from scratch. One of the requirements is that staging and production accounts should be separated from each other. At the same time, we’d like not to to create duplicate user accounts in both staging and production AWS accounts. Rather, there should be a central account(call it Admin), where all users will be created. Staging and production accounts can then be accessed by assuming IAM roles.

You can read more about this approach in the [AWS documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html#tutorial_cross-account-with-roles-1)

## TODO
1. Create a terraform configuration to set up AWS accounts
2. Add a bastion host in Admin Account, which will allow IAM users to connect to resources within private subnets in Production and Staging AWS accounts.
3. **Note** Don't fork this repository. Create you own repository and send us a link to it. You may describe some of the assumptions you had in the README file of your repository.

