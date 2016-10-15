echo "Setting up build env..."
npm install -g dockerfile_lint
echo "Build env ready."
echo "Initiating tests..."
chmod -R 0777 ./
echo ">>> Docker Lints:"
./specs/opsbox.spec.sh
if [ $? -eq 0 ]; then
  echo ">>> Docker Lints concluded and none failed."
else
  echo ">>> Tests failed."
  exit 1
fi
echo "Initiating DockerHub builds..."
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/cloudstack/trigger/9f7ad513-f6c4-45e9-b5e6-cc977910bf9f/'
curl --data build=true -X POST 'https://registry.hub.docker.com/u/opsforge/cloudstack-mysql/trigger/2e0c30b7-88b2-4c1a-8a55-f2cecd3fe70f/'
echo "DockerHub build triggered..."
