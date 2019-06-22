# blinkist-design-challenge
Design Challenge from Blinkist.

Many Amazon Web Services (AWS) customers require a data storage and analytics solution that offers more agility and flexibility than traditional data management systems. A data lake is an increasingly popular way to store and analyze data because it allows businesses to store all of their data, structured and unstructured, in a centralized repository. The AWS Cloud provides many of the building blocks required to help businesses implement a secure, flexible, and cost-effective data lake.

The data lake solution is an automated reference implementation that deploys a highly available, cost-effective data lake architecture on the AWS Cloud.  The solution is intended to address common customer pain points around conceptualizing data lake architectures, and automatically configures the core AWS services necessary to easily tag, search, share, and govern specific subsets of data across a business or with other external businesses. This solution allows users to catalog new datasets, and to create data profiles for existing datasets in Amazon Simple Storage Service (Amazon S3) and integrate with integrate with solutions like AWS Glue and Amazon Athena with minimal effort.

For the full solution overview visit [Blinkist-Design-Challenge](https://drive.google.com/drive/folders/1mBc51EEA4Rnb7nE2pr6VWEMz3kWUfKDg?usp=sharing).

## File Structure
The Automated Content Recommendation and Personalization project consists of services that facilitate the functional areas of the solution. These services are deployed to a serverless environment or managed services often referred as PaaS on AWS.

<pre>
|-deployment/ [folder containing templates and build scripts]
|-source/
  |-api/
  |-resource/
    |-access-validator/ [auxiliar module used to validate granular permissions]
    |-helper/ [custom helper for CloudFormation deployment template]
</pre>
Each service follows the structure of:

<pre>
|-service-name/
  |-lib/
    |-[service module libraries and unit tests]
  |-index.js/py [injection point for service]
  |-package.json
</pre>

## Getting Started

#### 01. Prerequisites
The following procedures assumes that all of the OS-level configuration has been completed. They are:

* [AWS Command Line Interface](https://aws.amazon.com/cli/)
* Node.js 8.x
* Python 3.6

The data lake solution is developed with Node.js  for the microservices that run in AWS Lambda and Angular 1.x for the console user interface. The latest version of the data lake solution has been tested with Node.js v8.10.

#### 02. Build the Automated Content Recommendation and Personalization Solution
Clone the blinkist-design-challenge GitHub repository:

```
git clone https://github.com/gopicares/blinkist-design-challenge.git
```

#### 03. Declare enviroment variables:

```
export AWS_REGION=<aws-region-code>
export VERSION_CODE=<version-code>
export DEPLOY_BUCKET=<source-bucket-base-name>
```
- **aws-region-code**: AWS region code. Ex: ```us-east-1```, ```us-west-2``` ...
- **version-code**: version of the package
- **source-bucket-base-name**: Name for the S3 bucket location where the template will source the Lambda code from. The template will append ```-[aws-region-code]``` to this bucket name. For example: ```./build-s3-dist.sh solutions v2.0.0```, the template will then expect the source code to be located in the ```solutions-[aws-region-code]``` bucket.

#### 04. Run the unit tests:
```
cd ./blinkist-design-challenge/deployment
chmod +x run-unit-tests.sh
./run-unit-tests.sh
```

#### 05. Build the solution for deployment:
```
chmod +x build-s3-dist.sh
./build-s3-dist.sh $DEPLOY_BUCKET $VERSION_CODE
```

#### 06. Upload deployment assets to your Amazon S3 bucket:
```
aws s3 cp ./dist s3://$DEPLOY_BUCKET/blinkist-design-challenge/latest --recursive --acl bucket-owner-full-control
```

#### 07. Deploy the data lake solution:
* From your designated Amazon S3 bucket where you uploaded the deployment assets, copy the link location for the deploy.template.
* Using AWS CloudFormation, launch stack using the copied Amazon S3 link for the deploy.template.

> Currently, the solution can be deployed in all regions.
