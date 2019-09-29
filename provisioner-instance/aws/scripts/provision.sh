#!/bin/bash

set -e

PIVNET_CLI_VERSION=0.0.52
OM_VERSION=4.0.1
BOSH_CLI_VERSION=6.1.0

pivnet_api_token=$1
om_domain=$2
om_username=$3
om_password=$4

# apt install fails if I don't sleep?!
sleep 40

sudo apt -qq -y update
sudo apt install -qq -y jq nano

# Install pivnet CLI
if [ ! -f /usr/bin/pivnet ]; then
  echo 'Downloading pivnet CLI...'

  wget -q https://github.com/pivotal-cf/pivnet-cli/releases/download/v$PIVNET_CLI_VERSION/pivnet-linux-amd64-$PIVNET_CLI_VERSION -O pivnet

  sudo mv pivnet /usr/bin
  sudo chmod +x /usr/bin/pivnet
else
  echo "Skipping pivnet CLI"
fi

# Install om CLI
if [ ! -f /usr/bin/om ]; then
  echo 'Downloading om CLI...'

  wget -q https://github.com/pivotal-cf/om/releases/download/$OM_VERSION/om-linux-$OM_VERSION -O om

  sudo mv om /usr/bin
  sudo chmod +x /usr/bin/om
else 
  echo "Skipping om CLI"
fi

# Login to pivnet
echo 'Logging in to pivnet...'
pivnet login --api-token $pivnet_api_token

# Install bosh CLI
if [ ! -f /usr/bin/bosh ]; then
  echo 'Downloading bosh CLI...'

  wget -q https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_CLI_VERSION}/bosh-cli-${BOSH_CLI_VERSION}-linux-amd64 -O bosh

  sudo mv bosh /usr/bin
  sudo chmod +x /usr/bin/bosh
else 
  echo "Skipping bosh CLI"
fi


# Fix issue with Azure SSH connections getting closed until I figure out what
echo 'Reconfiguring SSHD...'

sudo sed -i 's/ClientAliveInterval.*/ClientAliveInterval 3000/' /etc/ssh/sshd_config
sudo service ssh restart

echo 'Setting up profile scripts...'

mkdir -p ~/.bashrc.d
chmod 700 ~/.bashrc.d

cat << EOF > ~/.bash_profile
for file in ~/.bashrc.d/*.bashrc;
do
source "\$file"
done
EOF

cat << EOF > ~/.bashrc.d/om.bashrc
export OM_TARGET=https://$om_domain
export OM_USERNAME=$om_username
export OM_PASSWORD=$om_password
export OM_SKIP_SSL_VALIDATION=true
export PIVNET_TOKEN=$pivnet_api_token
EOF

chmod +x ~/.bashrc.d/*.bashrc

source ~/.bash_profile

# Setup config dir
if [ ! -d ~/config ]; then
  mkdir -p ~/config
fi

# Setup scripts dir
if [ ! -d ~/scripts ]; then
  mkdir -p ~/scripts
fi

# Convenience scripts
for file in /tmp/scripts-upload/*.sh; do
  chmod +x "$file"
  script_name=$(basename "$file" .sh)
  sudo mv -- "$file" "/usr/local/bin/${script_name}"
done

# Set up for file locks
echo 'Setup file locks'
sudo touch /var/run/paasify.lock
sudo chown ubuntu:ubuntu /var/run/paasify.lock

if [ -z "$om_domain" ]; then
  echo "OM domain not set, skipping auth configuration"
  exit
fi

# Configure authentication in OpsMan
echo 'Configuring OpsMan authentication...'
om configure-authentication -u $OM_USERNAME -p $OM_PASSWORD -dp $OM_PASSWORD
