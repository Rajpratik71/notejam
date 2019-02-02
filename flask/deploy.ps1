
docker build -t notejamserver -f server.Dockerfile .
### test container locally:
docker run --name notejamserver --rm -p 5000:5000 notejamserver