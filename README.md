# Virtual Development Environment

This is the virtual machine configuration I use on a daily basis.

Feel free to use or improve it ;)

**It contains:**
- Ubuntu 20.04 with Cinnamon
- openjdk-11
- latest LTS version of Node/NPM/yarn
- oh-my-zsh
- python
- docker & docker-compose
- IntelliJ Ultimate

## Usage

### Prerequisites

- Virtualbox installed
- Vagrant installed
- Guest Addition Plugin for Vagrant installed
  ```
  vagrant plugin install vagrant-vbguest
  ```
  
### Run

You just need to create the VM once (it takes a few minutes):

```
vagrant up
```

after that it will be available from Virtualbox.

### Remove

If something goes wrong, or you want to recreate the VM, you can remove it with:

```
vagrant destroy
```

## Known issues

- some of the steps in `setup.sh` may fail and it is hard to notice, 
there is no validation if everything was installed as planned

## TODOs:

- replace shell script with ansible