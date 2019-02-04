**************
Notejam: Flask in Azure
**************

Implementation of Flask version of Notejam on Microsoft Azure platform.

Running following technologies:
* Containerization of Flask application
* Kubernetes cluster, orchestrating Flask containers
* SQL Azure 

==========================
Set up Azure environment
==========================

The file flask_azure/create_infrastructure.ps1 contains the entire script to set up the Azure environment. Includes:
* Create resource group
* Azure Container Registry
* Azure Kubernetes Service
* Create secret in AKS that allows it to pull from ACR
* SQL Azure server and DB

==========================
Development workflow
==========================

-----
Container build
-----

The file flask/server.Dockerfile contains the instructions for the creation of a Docker image.

----
Kubernetes Deployment
----

The Kubernetes deployment is defined in flask_azure/notejamflask.yaml.

----
Building and deploying end-to-end
----

The script flask_azure/containerdeployment.ps1 contains the entire workflow of deploying a new version of the application, including:

* building the Dockerfile
* pushing to the Azure Container Registry
* deploying the Kubernetes deployment