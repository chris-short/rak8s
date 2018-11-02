# rak8s (pronounced rackets - /ˈrækɪts/)

Stand up a Raspberry Pi based Kubernetes cluster with Ansible

## Why?

* Raspberry Pis are rad
* Ansible is awesome
* Kubernetes is keen

ARM is going to be the datacenter and home computing platform of the future. It makes a lot of sense to start getting used to working in its unique environment.

Also, it's cheaper than a year of GKE. Plus, why not run Kubernetes in your home?

# Prerequisites

## Hardware

* Raspberry Pi 3 (3 or more)
* Class 10 SD Cards
* Network connection (wireless or wired) with access to the internet

## Software

* [Raspbian Lite](https://www.raspberrypi.org/downloads/raspbian/) (installed on each Raspberry Pi)

* Raspberry Pis should have static IPs
    * Requirement for Kubernetes and Ansible inventory
    * You can set these via OS configuration or DHCP reservations (your choice)

* Ability to SSH into all Raspberry Pis and escalate privileges with sudo
    * The pi user is fine just change its password

* [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) 2.2 or higher

* [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/) should be available on the system you intend to use to interact with the Kubernetes cluster.
    * If you are going to login to one of the Raspberry Pis to interact with the cluster `kubectl` is installed and configured by default on the master Kubernetes master.
    * If you are administering the cluster from a remote machine (your laptop, desktop, server, bastion host, etc.) `kubectl` will not be installed on the remote machine but it will be configured to interact with the newly built cluster once `kubectl` is installed.

## Recommendations

* Since Raspbian Lite is being used it's recommended that the video memory of the Raspberry Pi 3s be [set to its lowest setting](https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md) (16 MB).
* Setup SSH key pairs so your password is not required every time Ansible runs

# Stand Up Your Kubernetes Cluster

## Download the latest release or clone the repo:

```
git clone https://github.com/rak8s/rak8s.git
```

## Modify ansible.cfg and inventory

Modify the `inventory` file to suit your environment. Change the names to your liking and the IPs to the addresses of your Raspberry Pis.

If your SSH user on the Raspberry Pis are not the Raspbian default `pi` user modify `remote_user` in the `ansible.cfg`.

## Confirm Ansible is working with your Raspberry Pis:

```
ansible -m ping all
```
This may fail to ping if you have not setup SSH keys and only configured your Pi's with passwords
## Deploy, Deploy, Deploy

```
ansible-playbook cluster.yml
```

# Interact with Kubernetes

## CLI

Test your Kubernetes cluster is up and running:

```
kubectl get nodes
```

The output should look something like this:

```
NAME       STATUS    ROLES     AGE       VERSION
pik8s000   Ready     master    2d        v1.9.1
pik8s001   Ready     <none>    2d        v1.9.1
pik8s002   Ready     <none>    2d        v1.9.1
pik8s003   Ready     <none>    2d        v1.9.1
pik8s005   Ready     <none>    2d        v1.9.1
pik8s004   Ready     <none>    2d        v1.9.1
```

## Dashboard

rak8s installs the non-HTTPS version of the Kubernetes dashboard. This is not recommended for production clusters but, it simplifies the setup. Access the dashboard by running:

```
kubectl proxy
```

Then open a web browser and navigate to:
[http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)

# Need to Start Over?

Did something go wrong? Nodes fail some process or not joined to the cluster? Break Docker Versions with apt-update? 

Try the process again from the beginning:

```
ansible-playbook cleanup.yml
```
Wait for everything to run and then start again with:

```
ansible-playbook cluster.yml
```

# Where to Get Help

If you run into any problems please join our welcoming [Discourse](https://discourse.rak8s.io/) community. If you find a bug please open an issue and pull requests are always welcome.

# Etymology

**rak8s** (pronounced rackets - /ˈrækɪts/)

Coined by [Kendrick Coleman](https://github.com/kacole2) on [13 Jan 2018](https://twitter.com/KendrickColeman/status/952242602690129921)

# References & Credits

These playbooks were assembled using a handful of very helpful guides:

* [K8s on (vanilla) Raspbian Lite](https://gist.github.com/alexellis/fdbc90de7691a1b9edb545c17da2d975) by [Alex Ellis](https://www.alexellis.io/)
* [Installing kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
* [kubernetes/dashboard - Access control - Admin privileges](https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges)
* [Install using the convenience script](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script)

A very special thanks to [**Alex Ellis**](https://www.alexellis.io/) and the [OpenFaaS](https://www.openfaas.com/) community for their assitance in answering questions and making sense of some errors.
