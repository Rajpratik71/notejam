# Create Azure infrastructure
# - ACR
# - AKS

$rgName = "Notejam"
$rgLocation = "West Europe"
$ACRName = "ACRNotejam"
$ACRUrl = $ACRName + ".azurecr.io"
$AKSName = "AKSNotejam"

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
