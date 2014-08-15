#!/bin/bash

if [ ! -f /usr/bin/git ]; then
	apt-get update
	apt-get install -y git-core build-essential libssl-dev libcurl4-openssl-dev libreadline-dev
fi

if [ ! -d ~/.rbenv ]; then
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc

	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ ! -f ~/.rbenv/versions/1.9.3-p547/bin/ruby ]; then
	rbenv install 1.9.3-p547 -k
	rbenv global 1.9.3-p547
	gem update
fi

if [ ! -f ~/.rbenv/shims/bundler ]; then
	gem install bundler --no-ri --no-rdoc
fi

if [ ! -d ~/openstack-chef-repo ]; then
	git clone https://github.com/stackforge/openstack-chef-repo.git ~/openstack-chef-repo
fi

cd ~/openstack-chef-repo && bundler install
spiceweasel infrastructure.yml

## Configuration des modules python
if [ ! -d ~/.bash-git-prompt ]; then
  git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt
  echo 'source ~/.bash-git-prompt/gitprompt.sh' >> ~/.bashrc
fi

apt-get install -y python-setuptools python-dev libffi-dev libxslt1-dev libxml2-dev

if [ ! -d ~/.local ]; then
  easy_install pip

  pip install --user virtualenv
  pip install --user virtualenvwrapper

  echo 'export WORKON_HOME=~/.virtualenvs' >> ~/.bashrc
  echo 'mkdir -p $WORKON_HOME' >> ~/.bashrc
  echo 'source ~/.local/bin/virtualenvwrapper.sh' >> ~/.bashrc
  echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
  echo 'workon openstack' >> ~/.bashrc
fi

export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
source ~/.local/bin/virtualenvwrapper.sh
export PATH=$HOME/.local/bin:$PATH

if [ ! -d ~/.virtualenvs/openstack ]; then
  mkvirtualenv openstack
  pip install python-keystoneclient
  pip install python-novaclient
  pip install python-neutronclient
  pip install python-glanceclient
  pip install python-cinderclient
  pip install python-swiftclient
  pip install python-heatclient
  pip install python-ceilometerclient
  pip install python-troveclient
  pip install python-designateclient
  pip install python-openstackclient
fi

