ls -la ./
ls -la $HOME
echo "Setting up build env..."
npm install -g dockerfile_lint
echo "Build env ready."
echo "Initiating tests..."
chmod -R 0777 ./
echo ">>> Docker Lints:"
./tests/lint/opsbox.spec.sh
echo ">>> Docker Lints concluded and none failed."
echo "Initiating DockerHub builds..."
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/cloudstack/trigger/9f7ad513-f6c4-45e9-b5e6-cc977910bf9f/'
echo "DockerHub build triggered..."
exit 1
