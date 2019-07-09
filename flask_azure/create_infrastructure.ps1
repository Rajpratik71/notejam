# Create Azure infrastructure
# - ACR
# - AKS

$rgName = "Notejam"
$rgLocation = "West Europe"
$ACRName = "ACRNotejam"
$ACRUrl = $ACRName + ".azurecr.io"
$AKSName = "AKSNotejam"

$SQLserverName = "notejamsql"
$DBName = "notejamdb"
$SQLAdminUsn = "notejamadmin"

az login

# Create resource group
az group create --name $rgName --location $rgLocation

# Create Container Registry
az acr create -n $ACRName -g $rgName --sku Standard


# create Kubernetes cluster
az aks create -g $rgName -n $AKSName --generate-ssh-keys --location $rgLocation --node-vm-size='Standard_DS1_v2'

az aks get-credentials --resource-group $rgName --name $AKSName 

# test
kubectl get nodes

### Store ACR credentials as secret in AKS, so AKS can pull images from ACR

az acr login -n $ACRName
az acr update -n $ACRName --admin-enabled true

#$ACRloginserver = az acr show -n $ACRName --query loginServer
$ACRusn = az acr credential show -n $ACRName  --query username
$ACRpw = az acr credential show -n $ACRName  --query passwords[0].value

kubectl create secret docker-registry acrcred --docker-server=$ACRUrl --docker-username=$ACRusn --docker-password=$ACRpw --docker-email=yorickvanb@gmail.com


# Create Azure SQL server and DB

$SQLAdminPw = Read-Host -Prompt 'Input SQL server password'
az sql server create -l $rgLocation -g $rgName -n $SQLserverName -u $SQLAdminUsn -p $SQLAdminPw

# Allow access from all Azure services:
az sql server firewall-rule create -g $rgName -s $SQLserverName -n allowAzure --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
# Allow access from home: 
az sql server firewall-rule create -g $rgName -s $SQLserverName -n allowHome --start-ip-address 81.99.111.181 --end-ip-address 81.99.111.181
# allow access from Kubernetes public IP
az sql server firewall-rule create -g $rgName -s $SQLserverName -n allowKubernetes --start-ip-address 13.69.100.221 --end-ip-address 13.69.100.221

az sql db create -g $rgName -s $SQLserverName -n $DBName --service-objective S0