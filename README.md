# Kubernetes Microservice Deployment with Kind

This repository provides a set of scripts to easily deploy and manage a Python microservice on a local Kubernetes cluster using Kind (Kubernetes IN Docker).  It includes setup for the cluster, installation of an Ingress controller, and deployment of the microservice.

## Prerequisites

Before getting started, ensure you have the following tools installed:

* **Kind:**  For creating the local Kubernetes cluster.  See the [Kind installation guide](https://kind.sigs.k8s.io/docs/user/install/) for instructions.
* **kubectl:** For interacting with the Kubernetes cluster.  Usually installed alongside Kind.
* **Helm:** For managing the microservice and Ingress controller deployments. See the [Helm installation guide](https://helm.sh/docs/intro/install/) for instructions.
* **Docker:** For building and running the microservice container. See the [Docker installation guide](https://docs.docker.com/get-docker/) for instructions.
* **docker-compose:** For managing the microservice container.  Usually installed with Docker Desktop, or see the [installation guide](https://docs.docker.com/compose/install/) if needed.

## Getting Started

1. **Clone the repository:**

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Create the Kind cluster:**
   ```bash
   make create_cluster
   ```
   This command uses the provided kind.yaml configuration to create a cluster with a control plane node and two worker nodes, mapping ports 80 and 443 for external access.

3. **Install the Ingress controller and microservice:**
   ```bash
   make install
   ```
   This command will:
   - Create necessary namespaces.
   - Install the Nginx Ingress controller.
   - Deploy the Python microservice using Helm charts.

4. **Start the microservice container:**
   ```bash
   make start_container
   ```
   This builds and starts the microservice container using docker-compose.

## Makefile Commands

The Makefile provides several convenient commands for managing the deployment:

- `make help`: Displays this help message, listing all available commands and their descriptions.
- `make create_cluster`: Creates the Kubernetes cluster using Kind and the kind.yaml configuration file.
- `make delete_cluster`: Deletes the Kind Kubernetes cluster.
- `make install`: Installs the Ingress controller and the microservice. This is a combined target that runs several other install targets.
- `make install_ingress_controller`: Installs the Nginx Ingress controller.
- `make install_microservice`: Installs the Python microservice using Helm.
- `make install_namespaces`: Creates the required Kubernetes namespaces.
- `make uninstall`: Uninstalls the microservice and the Ingress controller. This is a combined target that runs several other uninstall targets.
- `make uninstall_ingress_controller`: Uninstalls the Nginx Ingress controller.
- `make uninstall_microservice`: Uninstalls the Python microservice.
- `make uninstall_namespaces`: Deletes the created namespaces.
- `make start_container`: Builds and starts the microservice container using docker-compose.
- `make stop_container`: Stops the microservice container using docker-compose.

## Configuration

- `kind.yaml`: This file configures the Kind cluster. You can modify it to adjust the number of nodes, port mappings, etc.
- **Helm Charts**: The microservice deployment is managed using Helm charts. You can customize the chart values to configure the microservice further.
- `docker-compose.yml`: This file configures the microservice container. Modify it to adjust ports, volumes, etc.

## Verification
### Kubernetes deployment
After deploying the microservice, you can verify its status using kubectl:
   ```bash
   kubectl get deployments -n ingress-nginx
   kubectl get pods -n ingress-nginx
   ```
The Kubernetes deployment exposes the microservice at ports 80 and 443.  You can access the following endpoints:
   ```bash
   curl localhost/me1
   curl localhost/me2
   ```

### Docker Compose Deployment
When running with Docker Compose, the microservice is exposed at port 5000.  You can verify it with:
   ```bash
   curl localhost:5000/me
   ```

## Cleanup
To remove the deployed resources, run the following commands:
   ```bash
   make stop_container
   make uninstall
   make delete_cluster
   ```
This will stop the container, uninstall the Helm charts, and delete the Kind cluster.
