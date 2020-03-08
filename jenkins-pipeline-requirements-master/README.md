# Jenkins CI/CD Pipeline Requirements
The following jobs, stages and steps have been reviewed and approved by the HP Cloud Security team. The steps marked as required are mandatory for all Jenkins pipelines to maintain HP security compliance.

## Required Jobs
1. Build Job
2. Deployment Job
3. Rotate Servers Job

## Build Job

### _Stages_

![Image of Build Pipeline](/images/BuildPipeline.PNG)

**SCM**
> The first step is to checkout your code from SCM. This can be done in its own stage or as part of the Build/Test Code stage

|Step|Description|Example Code|Required|
|-----|----------|------------|--------|
|Checkout Code|Checkout code from SCM. Using an agent will always checkout the code.| `agent {label 'ecs'}`| Yes |

**Build/Test Code**
>  Build your code, make sure that it compiles. Run unit/integration tests. Build deployment artifacts. The developers should be able to receive fast feedback, this stage should take less than 10 minutes to run. 

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Build Code|Build your code, make sure that it compiles.| `sh 'gradle build'`| Yes |
|Run Unit/Integration Tests| Test your application | `sh 'gradle test'`| Yes |
|Build Deployment Artifact| Package your application into a deployment artifact| `sh 'gradle war'`| Yes |

**Code Assessment**
> Scan your code for code coverage, security vulnerabilities, following code guidelines, and for viruses.

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Code Coverage|Scan your code for code coverage using SonarQube| | No |
|Vulnerability Scan|Scan your code for security vulnerabilities using Veracode| | Yes |
|Coding Guidelines|Scan your code for following coding guidelines using SonarLint| | No |
|Virus Scan|Scan your code for viruses| | Yes (if desktop app) |

**Docker Build**
> Provision Docker repository. Build your Docker container. Tag your container. Push to your Docker repository. Scan your Docker image for vulnerabilities using Anchore Engine.

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Docker Repository|Provision Docker repository using Terraform|  | Yes |
|Docker Build|Build your Docker container| `sh 'docker build -t your-app .` | Yes |
|Docker Tag|Tag your container| `sh 'docker tag $repo:latest $ecrUrl:$version` | Yes |
|Docker Push|Push to your Docker repository| `sh 'docker tag $repo:latest $ecrUrl:$version` | Yes |
|Docker Tag|Tag your container| `sh 'docker push $ecrUrl:$version` | Yes |
|Docker Vulnerability Scan|Scan your Docker image for vulnerabilities using Anchore Engine| `dockerSecurityScan(ecrUrl, dockerImageVersion, "$WORKSPACE/Dockerfile")` | Yes |

**Deploy To Development Environment**
> Call Deployment Job, passing in development environment's variables

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Call DEV Deployment Job|Call Deployment Job, passing in development environment's variables| `build job: 'Deploy', parameters: [string(name: 'env', value: 'dev')]` | Yes |

**Regression Test**
> Run regression tests against your Dev environment

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Regression Test|Run regression tests against your Dev environment| | No |

**Prompt for deployment to Intergration Environment**
> Prompt for deployment to Intergration Environment

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Prompt|Prompt for deployment to Intergration Environment. Timeout after 1 hour.| `options { timeout(time: 1, unit: 'HOURS') } step { input 'Deploy to ITG?' }` | No |

**Deploy To Intergration Environment**
> Call Deployment Job, passing in ITG environment's variables

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Call ITG Deployment Job|Call Deployment Job, passing in ITG environment's variables| `build job: 'Deploy', parameters: [string(name: 'env', value: 'itg')]` | Yes |

**Prompt for deployment to Production Environment**
> Prompt for deployment to Production Environment

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Prompt|Prompt for deployment to Production Environment. Timeout after 1 hour.| `options { timeout(time: 1, unit: 'HOURS') } step { input 'Deploy to PRO?' }` | Yes |

**Deploy To Production Environment**
> Call Deployment Job, passing in PRO environment's variables

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Call PRO Deployment Job|Call Deployment Job, passing in PRO environment's variables| `build job: 'Deploy', parameters: [string(name: 'env', value: 'pro')]` | Yes |


## Deployment Job

### _Stages_

![Image of Deployment Pipeline](/images/DeploymentPipeline.PNG)

**Update Build's Display Name**
> Update's the build's display name so that the environment is listed with the build number

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Update Display Name| Update's the build's display name so that the environment is listed with the build number | `currentBuild.displayName = "#${env.BUILD_NUMBER} - ${params.env}"` | Yes |

**RDS**
> Use Terraform to provision/update RDS instance. Run DB migrations

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Provision RDS Instance| Use Terraform to provision/update RDS instance | `sh 'terraform apply'` | Yes |
|Run DB Migrations| Use a DB migration tool to apply DB schema changes | `sh 'liquibase update'` | Yes |

**ECS Cluster**
> Use Terraform to provision/update the ECS Cluster

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Provision ECS Cluster| Use Terraform to provision/update the ECS Cluster | `sh 'terraform apply'` | Yes |


**ECS Service**
> Use Terraform to provision/update the ECS Service

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Provision ECS Service| Use Terraform to provision/update the ECS Service | `sh 'terraform apply'` | Yes |

**Smoke Test**
> Smoke Test your deployment, make sure it is working properly. Rollback deployment if smoke test fails

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Smoke Test| Smoke Test your deployment, make sure it is working properly |  | No |
|Rollback| Automatically rollback deployment if smoke test fails |  | No |

## Rotate Servers Job

### _Stages_

![Image of Rotate Servers Pipeline](/images/RotateServersPipeline.PNG)

**ECS Cluster**
> Use Terraform to rotate the servers in your ECS Cluster. This job runs weekly and picks up the lastest AMIs with patches and security updates.

|Step|Description|Example Code|Required|
|-----|-----------|------------|--------|
|Rotate Servers| Use Terraform to rotate the servers in your ECS Cluster  | | Yes |
