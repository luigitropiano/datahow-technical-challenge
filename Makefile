.PHONY: help create_cluster delete_cluster install install_ingress_controller

# Set 'help' as the default goal
.DEFAULT_GOAL := help

# Specify the shell to use (bash in this case)
SHELL := /bin/bash  

# Variable for the scripts directory
BIN_DIR := bin

help:	## Show this help.
	@grep -E '(\s##\s|^##\s)' $(MAKEFILE_LIST) | grep -E -v '^--' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m  %-35s\033[0m %s\n", $$1, $$2}'

chmod_bin:
	@find bin -type f -exec chmod +x {} \;
	@echo "Executable permissions set for all files in bin."

create_cluster: ## Create the kubernetes cluster with kind
	@echo "Executing create_cluster.sh..."
	@$(SHELL) bin/create_cluster.sh

delete_cluster: ## Delete kind cluster
	@echo "Executing delete_cluster.sh..."
	@$(SHELL) bin/delete_cluster.sh

start_container: chmod_bin ## Start the container with docker-compose
	@echo "Executing start_container..."
	@$(SHELL) bin/start_container.sh

stop_container: chmod_bin ## Stop the container
	@echo "Executing stop_container..."
	@$(SHELL) bin/stop_container.sh

install: chmod_bin --install_namespaces --install_ingress_controller --install_microservice ## Install ingress-controller and microservice

--install_ingress_controller: chmod_bin ## Install the nginx ingress controller into the local kind kubernetes cluster
	@echo "Executing install_ingress_controller.sh..."
	@$(SHELL) bin/install_ingress_controller.sh

--install_microservice: chmod_bin ## Install the python microservice
	@echo "Executing install_microservice.sh..."
	@$(SHELL) bin/install_microservice.sh

--install_namespaces: chmod_bin ## Create the required namespaces
	@echo "Executing install_namespaces.sh..."
	@$(SHELL) bin/install_namespaces.sh

uninstall: chmod_bin --uninstall_microservice --uninstall_ingress_controller --uninstall_namespaces ## Uninstall microservice and ingress-controller

--uninstall_ingress_controller: chmod_bin ## Uninstall the nginx ingress controller into the local kind kubernetes cluster
	@echo "Executing uninstall_ingress_controller.sh..."
	@$(SHELL) bin/uninstall_ingress_controller.sh

--uninstall_microservice: chmod_bin ## Uninstall the python microservice
	@echo "Executing uninstall_microservice.sh..."
	@$(SHELL) bin/uninstall_microservice.sh

--uninstall_namespaces: chmod_bin ## Delete the required namespaces
	@echo "Executing uninstall_namespaces.sh..."
	@$(SHELL) bin/uninstall_namespaces.sh

