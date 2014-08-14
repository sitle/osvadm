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

