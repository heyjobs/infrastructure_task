## Infrastructure Challenge
The purpose of this challenge is to enable prospective HeyJobs infrastructure engineers to show us how they solve problems.
This scenario is based on an every-day situation in DevOps, where you have to pick up and improve infrastructure code/design that is not ideal.

What we are looking for is readable code, and simple rather than complex design.   Document the code where you think necessary, and include a description of your approach/thinking in a markdown file.

## Scenario
Neu-Automat Berlin is a one year old startup that runs a network of cafeterias in the city.  They have five cafeterias, and all food and drink is served from vending machines.  Customers order using the Neu-Automat mobile app, which also unlocks the vending machine using one-time codes.

Being a startup, Neu-Automat are developing new product features as a priority.  However they recently had a major incident where all vending machine prices were set to €0.50 for all products. 

They realised that the product pricing is set using an XML file, which is uploaded to an S3 bucket which each vending machine app downloads once per day. A junior developer was testing dynamic pricing functionality and managed to over-write the production XML file by accident.

## Challenge
It was discovered that there is an S3 bucket (dev-xml-transfer) which all users in the AWS account have read-write access to.   The challenge is to improve the current infrastructure setup to prevent a repeat of the accident.

#### Requirements
* Senior developers (snr_dev_*) should have read-write access to the S3 bucket dev-xml-transfer.
* Junior developers (jnr_dev_*) should have read-only access to the S3 bucket dev-xml-transfer.
* Other users in the AWS account should not have access to the S3 bucket dev-xml-transfer.


#### Tasks
1. Briefly explain your approach to solving the challenge (in a markdown file).
2. Modify the existing code to achieve the above requirements.
3. Optionally present a couple of next iteration changes, if there are further improvements that can be made.

#### General Notes
Neu-Automat use Ansible for IAM management, and Terraform for the underlying infrastructure definition. You are free to use either or both to achieve the desired outcome.

You will need an AWS account to complete the challenge, although it should not incur any AWS charges.

Complete the challenge in your own repo, and then send us a link so we can review it.

#### Ansible Notes
Users are defined in /ansible/group_vars/all/aws_users.yml, and created using the /ansible/roles/create_aws_users.yml role. 

The playbook for updating users is /ansible/setup_aws_users.yml, which is also imported into /ansible/site.yml.

#### Terraform Notes
Underlying infrastructure is managed with Terraform. The S3 bucket is created by /tf/production/main.tf, relying on the module /tf/modules/create_s3_bucket.

The configuration of the S3 bucket is done with variables in /tf/produciton/terraform.tfvars.  And the bucket policy is a templated file, /tf/production/policies/dev_xml_bucket_policy.json.tpl.

#### Setup
```shell
$ cd ansible/
$ ansible-playbook site.yml 

PLAY [setup our AWS users accounts] ******************************************************************************************************************

TASK [create_aws_users : Create developers accounts, adding to the PowerUsers group] *****************************************************************
changed: [localhost] => (item=snr_dev_a)
changed: [localhost] => (item=snr_dev_b)
changed: [localhost] => (item=snr_dev_c)
changed: [localhost] => (item=snr_dev_d)
changed: [localhost] => (item=snr_dev_e)
changed: [localhost] => (item=jnr_dev_m)
changed: [localhost] => (item=jnr_dev_n)
changed: [localhost] => (item=jnr_dev_o)
changed: [localhost] => (item=jnr_dev_p)
changed: [localhost] => (item=jnr_dev_q)

PLAY RECAP *******************************************************************************************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0   

$ aws iam list-users
{
    "Users": [
        {
            "Path": "/",
            "UserName": "circleci_beanstalk_deploy_user",
            "UserId": "AIDAJA4LQC7PBR74J7CSA",
            "Arn": "arn:aws:iam::533655792172:user/circleci_beanstalk_deploy_user",
            "CreateDate": "2018-10-13T17:06:03Z"
        },
        {
            "Path": "/",
            "UserName": "doug",
            "UserId": "AIDAIJ7UQI5OKTHVEHIPW",
            "Arn": "arn:aws:iam::533655792172:user/doug",
            "CreateDate": "2018-10-04T15:07:12Z"
        },
        {
            "Path": "/",
            "UserName": "InitialTerraformUser",
            "UserId": "AIDAJ3YO3KIVUTTGQ4QCU",
            "Arn": "arn:aws:iam::533655792172:user/InitialTerraformUser",
            "CreateDate": "2018-10-06T19:01:44Z"
        },
        {
            "Path": "/",
            "UserName": "jnr_dev_m",
            "UserId": "AIDAIETXUMP5MHRMNXU44",
            "Arn": "arn:aws:iam::533655792172:user/jnr_dev_m",
            "CreateDate": "2018-10-15T08:23:41Z"
        },
        {
            "Path": "/",
            "UserName": "jnr_dev_n",
            "UserId": "AIDAJ5MJ3Z7ZICK3EQLBU",
            "Arn": "arn:aws:iam::533655792172:user/jnr_dev_n",
            "CreateDate": "2018-10-15T08:23:45Z"
        },
        {
            "Path": "/",
            "UserName": "jnr_dev_o",
            "UserId": "AIDAIPD2FQT5K3CN6NJOS",
            "Arn": "arn:aws:iam::533655792172:user/jnr_dev_o",
            "CreateDate": "2018-10-15T08:23:50Z"
        },
        {
            "Path": "/",
            "UserName": "jnr_dev_p",
            "UserId": "AIDAJI7VERDNYCZPVEKOE",
            "Arn": "arn:aws:iam::533655792172:user/jnr_dev_p",
            "CreateDate": "2018-10-15T08:23:55Z"
        },
        {
            "Path": "/",
            "UserName": "jnr_dev_q",
            "UserId": "AIDAIMT3CVXQDRSVCRJ4C",
            "Arn": "arn:aws:iam::533655792172:user/jnr_dev_q",
            "CreateDate": "2018-10-15T08:23:59Z"
        },
        {
            "Path": "/",
            "UserName": "snr_dev_a",
            "UserId": "AIDAI547LOTSRED35GM5U",
            "Arn": "arn:aws:iam::533655792172:user/snr_dev_a",
            "CreateDate": "2018-10-15T08:23:21Z"
        },
        {
            "Path": "/",
            "UserName": "snr_dev_b",
            "UserId": "AIDAIJ5YZYX35PBDSWMLG",
            "Arn": "arn:aws:iam::533655792172:user/snr_dev_b",
            "CreateDate": "2018-10-15T08:23:25Z"
        },
        {
            "Path": "/",
            "UserName": "snr_dev_c",
            "UserId": "AIDAITOWULVSFZEWSLZ54",
            "Arn": "arn:aws:iam::533655792172:user/snr_dev_c",
            "CreateDate": "2018-10-15T08:23:29Z"
        },
        {
            "Path": "/",
            "UserName": "snr_dev_d",
            "UserId": "AIDAI3VFE7STRMK7QYNBI",
            "Arn": "arn:aws:iam::533655792172:user/snr_dev_d",
            "CreateDate": "2018-10-15T08:23:33Z"
        },
        {
            "Path": "/",
            "UserName": "snr_dev_e",
            "UserId": "AIDAJEIQFV2XXF7BDPFSS",
            "Arn": "arn:aws:iam::533655792172:user/snr_dev_e",
            "CreateDate": "2018-10-15T08:23:37Z"
        }
    ]
}
$
$
$ cd ../tf/production/
$ terraform plan -out=example_plan.tfplan
var.aws_account
  AWS account.

  Enter a value: 533655792172

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.template_file.s3_bucket_policy: Refreshing state...
aws_s3_bucket.created_bucket: Refreshing state... (ID: dev-xml-transfer)

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + module.create_s3_bucket.aws_s3_bucket.created_bucket
      id:                          <computed>
      acceleration_status:         <computed>
      acl:                         "private"
      arn:                         <computed>
      bucket:                      "dev-xml-transfer"
      bucket_domain_name:          <computed>
      bucket_regional_domain_name: <computed>
      force_destroy:               "false"
      hosted_zone_id:              <computed>
      policy:                      "{\n   \"Version\": \"2008-10-17\",\n   \"Statement\": [\n       {\n           \"Effect\": \"Allow\",\n           \"Action\": [\"s3:ListBucket\"],\n           \"Principal\": { \"AWS\": \"533655792172\" },\n           \"Resource\": [\"arn:aws:s3:::dev-xml-transfer\"]\n       },\n       {\n           \"Effect\": \"Allow\",\n           \"Principal\": { \"AWS\": \"533655792172\" },\n           \"Action\": [\n               \"s3:PutObject\",\n               \"s3:GetObject\",\n               \"s3:DeleteObject\"\n           ],\n           \"Resource\": [\"arn:aws:s3:::dev-xml-transfer/*\"]\n       }\n   ]\n}\n"
      region:                      <computed>
      request_payer:               <computed>
      tags.%:                      "1"
      tags.Terraform:              "True"
      versioning.#:                <computed>
      website_domain:              <computed>
      website_endpoint:            <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: example_plan.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "example_plan.tfplan"

$ terraform apply "example_plan.tfplan"
 module.create_s3_bucket.aws_s3_bucket.created_bucket: Creating...
      acceleration_status:         "" => "<computed>"
      acl:                         "" => "private"
      arn:                         "" => "<computed>"
      bucket:                      "" => "dev-xml-transfer"
      bucket_domain_name:          "" => "<computed>"
      bucket_regional_domain_name: "" => "<computed>"
      force_destroy:               "" => "false"
      hosted_zone_id:              "" => "<computed>"
      policy:                      "" => "{\n   \"Version\": \"2008-10-17\",\n   \"Statement\": [\n       {\n           \"Effect\": \"Allow\",\n           \"Action\": [\"s3:ListBucket\"],\n           \"Principal\": { \"AWS\": \"533655792172\" },\n           \"Resource\": [\"arn:aws:s3:::dev-xml-transfer\"]\n       },\n       {\n           \"Effect\": \"Allow\",\n           \"Principal\": { \"AWS\": \"533655792172\" },\n           \"Action\": [\n               \"s3:PutObject\",\n               \"s3:GetObject\",\n               \"s3:DeleteObject\"\n           ],\n           \"Resource\": [\"arn:aws:s3:::dev-xml-transfer/*\"]\n       }\n   ]\n}\n"
      region:                      "" => "<computed>"
      request_payer:               "" => "<computed>"
      tags.%:                      "" => "1"
      tags.Terraform:              "" => "True"
      versioning.#:                "" => "<computed>"
      website_domain:              "" => "<computed>"
      website_endpoint:            "" => "<computed>"
module.create_s3_bucket.aws_s3_bucket.created_bucket: Creation complete after 6s (ID: dev-xml-transfer)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

$
$ aws s3api get-bucket-location --bucket dev-xml-transfer
{
    "LocationConstraint": "eu-west-1"
}

```
