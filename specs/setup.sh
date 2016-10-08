echo "Setting up build env..."
apt-get update
apt-get install nodejs npm curl wget git jq -y
ln -s "$(which nodejs)" /usr/bin/node
npm install -g dockerfile_lint
echo "Build env ready."
