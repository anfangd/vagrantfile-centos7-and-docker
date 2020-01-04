#!/bin/sh

# Install Commands
yum -y install \
    unzip git vim httpie \
    "Development Tools" zlib-devel openssl-devel ncurses-devel libffi-devel sqlite-devel.x86_64 readline-devel.x86_64 bzip2-devel.x86_64

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# Install Docker & docker-compose
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce
systemctl enable docker
systemctl start docker
curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > docker-compose
mv docker-compose /usr/local/bin/
chmod +x /usr/local/bin/docker-compose
gpasswd -a vagrant docker
systemctl restart docker
docker -v
docker-compose -v

# Install Node.js and npm
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum -y install nodejs
node -v
npm -v

# Install the heroku cli
export PATH=/usr/local/bin:$PATH
curl https://cli-assets.heroku.com/install.sh | sh
heroku -v

# Install aws cli version 2
# cf. https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-linux-mac.html
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws2 --version

# Install aws eblic
# cf. https://github.com/aws/aws-elastic-beanstalk-cli-setup
git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
echo 'export PATH="/root/.ebcli-virtual-env/executables:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
echo 'export PATH=/root/.pyenv/versions/3.7.2/bin:$PATH' >> /root/.bash_profile && source /root/.bash_profile
