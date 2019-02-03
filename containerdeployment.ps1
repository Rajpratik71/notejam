# Development workflow
# - Build image and run container
# - Push image to Azure Container Registry
# - Apply Kubernetes Deployment

$rgName = "Notejam"
$rgLocation = "West Europe"
$ACRName = "ACRNotejam"
$ACRUrl = $ACRName + ".azurecr.io"
$AKSName = "AKSNotejam"

$imageName = 'notejamserver'
$containerName = 'notejamserver'

cd flask

docker build -t $imageName -f server.Dockerfile .
### test container locally:
docker run --name $containerName --rm -p 5000:5000 $imageName
# remove container
docker container rm $containerName -f

######## Azure login required from here
az login

######## Push hangfire images to Azure Container Registry ########
az acr login -n $ACRName
az acr show -n $ACRName

### Push image to Registry
$remoteImageName = $ACRUrl + '/' + $imageName
docker tag $imageName $remoteImageName
docker push $remoteImageName

######## Connect to Kubernetes cluster in Azure and deploy ########
az aks get-credentials --resource-group $rgName --name $AKSName

### test
kubectl get nodes

### deploy stack
kubectl apply -f notejamflask.yml