# Puppet Playground

Welcome to the Puppet Playground where you can play with Puppet and also do some serious stuff.

To remove, fix or add entries please send pull requests for [Vagrantfile](https://github.com/weldpua2008/puppet-playground/blob/master/Vagrantfile).


## Installation

You need **[VirtualBox](https://www.virtualbox.org/)** , **[Vagrant](http://www.vagrantup.com/)** and **Git** installed on your system.

Then you can just clone this repo to a work directory of your choice (here puppet-playground):

    git clone https://github.com/weldpua2008/puppet-playground.git puppet-playground

and move into the newly created directory.

    cd puppet-playground


#### Vagrantfile cachier cachier
Vagrantfile can use the cachier cachier, you can install it with:

    vagrant plugin install vagrant-cachier


## Basic usage
Once you have moved into the playground you have at disposal various commands:

  **1** - **Vagrant**. Show available subcommands with:

    vagrant

  Show the Vagrant status with:

    vagrant status



## Install modules

The Puppet code is placed in 2 locations of the playground:

- Default manifest is **manifests/init.pp**, here you play with your Puppet code.
  You can test native resources or use resources and classes provided by modules.

- Modules are in **modules/**, you can populate this directory in different ways:

**1** - If you want to **quick test Puppet resources** without using modules just write your Puppet code in **manifests/init.pp** (see below).

      vi manifests/init.pp

**2** - If you want to test modules from the **Puppet Forge** you can install them with:

      puppet module install <modulename>  --modulepath modules/

  So, for example you can type:

      puppet module install puppetlabs-apache  --modulepath modules/


**3** - If you want to **test your own modules** just place them in the modules dir, one module per directory, as you would do in your puppet master.


## Vagrant Usage

Whatever method you use to populate the modules’ directory and the default manifest directory, you can test your Puppet code on the running Vagrant boxes. First, review (if you want) the default Vagrantfile provided by puppet-playground. You will see a normal MultiVM setup with masterless Puppet integration

    cat Vagrantfile

You can see the available VMs with:

    vagrant status

Expect an output like the one below:

    Current VM states:
    
    Centos67_64              not created (virtualbox)
    Centos72_64              not created (virtualbox)
    Ubuntu1404_64            not created (virtualbox)


Note that this list is going to be updated and corrected.

You can run any of the provided Vagrant boxes with:

    vagrant up Centos67_64

This may take some minutes, the first time you run it, to download the base box from the Internet.

Once created the VM, you can connect to it with:

    vagrant ssh Centos67_64

Note that at the moment headless mode is disabled, so you’ll see the VirtualBox console window pop up. If you encounter problems with ssh, you should be able to login with user ‘vagrant’ and password ‘vagrant’ and then sudo -s.

To exit from the shell on the VM

    vm# exit

To restart your VM:

    vagrant reload Centos67_64

To destroy and rebuild from scratch:

    vagrant destroy Centos6_64
    vagrant up Centos6_64


## Work with Puppet

Once you see that Vagrant is doing its job, you can start to play with Puppet code: edit the default Puppet manifest applied on the boxes:

    vi manifests/init.pp

This is your test playground: add resources, use modules, declare classes…
You can place simple resources like:

    file { 'motd':
      path    => '/etc/motd',
      content => 'Hi there',
    }

Or use modules you’ve previously placed in the modules/ dir.

    class { 'wordpress':
    }

Or whatever Puppet code you might want to apply.

If you need to provide custom files, the sanest approach is to place them in the templates directory of a custom “site” module (call it ‘site’ or however you want) and refer to it using the content parameter:

    file { 'motd':
      path    => '/etc/motd',
      content => template('site/motd'),
    }

This will populate /etc/motd with the template placed in **puppet-playground/modules/site/templates/motd**.

To test your code’s changes on a single node, you have two alternatives:

From your host, in the puppet-playground directory:

    vagrant provision Centos67_64

From the VM you have created:

    vagrant ssh Centos67_64

Once you’ve logged in the VM, get the superpowers and run Puppet:

    vm# sudo -s
    vm# puppet apply -v --modulepath '/tmp/vagrant-puppet/modules-0' --pluginsync /tmp/vagrant-puppet/manifests/init.pp

You can also edit the manifests file both from your host or inside a VM:

From your host (having your cwd in puppet-playground directory):

    vi manifests/init.pp

From the VM (once connected via ssh):

    vm# sudo -s
    vm# cd /tmp/vagrant-puppet/
    vm# vi manifests/init.pp

If you have more VMs active you can test your changes on all of them with a simple:

    vagrant provision


## Caveats and things to know



## Support and Bugs

Please submit bug filings, pull requests and suggestions via GitHub.

This Puppet Playground might become more and more useful if:

  - More Working vagrant Boxes are provided for different OS. You can add them to [Vagrantfile](https://github.com/weldpua2008/puppet-playground/blob/master/Vagrantfile)


  - New ideas and integrations are delivered (ie: Travis, Jenkins for automatic checks of deployed toasters)

Any contribution is very welcomed: the Playground is funnier if there are more kids around ;-)
