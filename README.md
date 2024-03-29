# Automated Content Recommendation and Personalization
A Design Challenge from Blinkist.

Many companies require a data storage and analytics solution that offers more agility, flexibility at the same time natively integrates with machine learning toolsets to perform content discovery and personalization. A data fabric is an increasingly popular way to store, analyze data, create models and expose them as APIs to web servers or to 3rd party vendors. Data fabric also allows businesses to store all of their data, structured and unstructured, in a centralized repository and generate insights out of them. The AWS Cloud provides not only the building blocks required to help businesses implement a secure, flexible, and cost-effective data fabric but also provides recommendation/personalization engines as commodity services. For advanced customers, they provide platform to build, train, tune and continuosly deploy machine learning models.

The solution is an automated reference architecture implementation that deploys a highly available, cost-effective data fabric architecture on the AWS Cloud. It also provides template to create and delete Amazon sagemaker instances via cloudformation template. API Endpoints are exposed to work with Data Fabric Services and related AI/ML platform(Sagemaker).  

The solution is intended to :
1. Enable ecommerce businesses to collect user engagement events along with user and item attributes through Amazon Kinesis, perform transformation through AWS Lambda, tag and store them in Amazon Simple Storage Service (Amazon S3), catalogue them in Glue Data Catalogue for ad-hoc querying using Redshift Spectrum/Athena.
2. Address common pain points around conceptualizing end-end recommendation engine architectures on Amazon Sagemaker Platform. 

For the full solution overview visit [blinkist-design-challenge/presentation](https://github.com/gopicares/blinkist-design-challenge/blob/master/presentation/Blinkist%20Design%20Challenge%20v1.0.pdf)

## Architecture

**Architecture with Constraints**

![Solution Component Diagram](readmeImages/ProposedSAContraints.png)

&nbsp;

**Target State Architecture**

![Solution Component diagram](readmeImages/TargetArchitecture.png)

&nbsp;

## File Structure
The Automated Content Recommendation and Personalization project consists of services that facilitate the functional areas of the solution. These services are deployed to a serverless environment or managed services often referred as PaaS on AWS.

<pre>
|-deployment/ [folder containing templates and build scripts]
  |-templates/
  |-resources/
  |-functions/
|-presentation/ [folder containing the presentation material]
|-readmeImages/ [folder containing image files for readMe]
|-source/
  |-api/
  |-lambda/
  |-kinesis_to_S3/
  |-glue/

|-tests/ [folder containing unit testing scripts]
</pre>

## Getting Started

#### 01. Prerequisites
The following procedures assumes that all of the OS-level configuration has been completed. They are:

* [AWS Command Line Interface](https://aws.amazon.com/cli/)
* Python 3.6

The automated content discovery and personalization solution is developed on python 3.6 for the microservices that run in AWS Lambda and exposed as RESTful API in API GW

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
cd ./blinkist-design-challenge/tests
chmod +x run-unit-tests.sh
./run-unit-tests.sh
```

#### 05. Build the solution for deployment:
```
* use aws cloudformation create package or sam package
```

#### 06. Upload deployment assets to your Amazon S3 bucket:
```
aws s3 cp ./functions/ s3://apps.recommendation.dev.eu-central-1/functions --exclude "*" --include "*.zip" --sse aws:kms --recursive
```

#### 07. Deploy the solution:
```
cd ./blinkist-design-challenge/deployment/
chmod +x deploy.sh
./deploy.sh
```

> Currently, the solution can be deployed in all regions.

#### 08. Deploy the solution:
```
cd ./blinkist-design-challenge/deployment/
chmod +x cleanup.sh
./cleanup.sh
```

## License Summary

This sample code is made available under a GPL license. See the LICENSE file.

&nbsp;
