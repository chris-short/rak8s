# rak8s

(pronounced rackets - /ˈrækɪts/)

Stand up a Raspberry Pi based Kubernetes cluster with Ansible

[**rak8s**](https://github.com/rak8s) is maintained by [Chris Short](https://github.com/chris-short) and a community of open source folks willing to help.

## Why?

* Raspberry Pis are rad
* Ansible is awesome
* Kubernetes is keen

ARM is going to be the datacenter and home computing platform of the future. It makes a lot of sense to start getting used to working in its unique environment.

Also, it's cheaper than a year of GKE. Plus, why not run Kubernetes in your home?

## Prerequisites

### Hardware

* Raspberry Pi 3 (3 or more)
* Class 10 SD Cards
* Network connection (wireless or wired) with access to the internet

### Software

* [Raspbian Lite](https://www.raspberrypi.org/downloads/raspbian/) (installed on each Raspberry Pi)

* Raspberry Pis should have static IPs
    * Requirement for Kubernetes and Ansible inventory
    * You can set these via OS configuration or DHCP reservations (your choice)

* Ability to SSH into all Raspberry Pis and escalate privileges with sudo
    * The pi user is fine
    * Please change the pi user's password

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 2.7.1 or higher

* [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/) should be available on the system you intend to use to interact with the Kubernetes cluster.
    * If you are going to login to one of the Raspberry Pis to interact with the cluster `kubectl` is installed and configured by default on the master Kubernetes master.
    * If you are administering the cluster from a remote machine (your laptop, desktop, server, bastion host, etc.) `kubectl` will not be installed on the remote machine but it will be configured to interact with the newly built cluster once `kubectl` is installed.

### Recommendations

* Setup SSH key pairs so your password is not required every time Ansible runs

## Stand Up Your Kubernetes Cluster

### Download the latest release or clone the repo:

``` bash
git clone https://github.com/rak8s/rak8s.git
```

### Modify ansible.cfg and inventory

Modify the `inventory` file to suit your environment. Change the names to your liking and the IPs to the addresses of your Raspberry Pis.

If your SSH user on the Raspberry Pis are not the Raspbian default `pi` user modify `remote_user` in the `ansible.cfg`.

### Confirm Ansible is working with your Raspberry Pis:

``` bash
ansible -m ping all
```

This may fail to ping if you have not setup SSH keys and only configured your Pi's with passwords

## Deploy, Deploy, Deploy

``` bash
ansible-playbook cluster.yml
```

## Shutdown

```bash
ansible-playbook shutdown.yml
```


## Interact with Kubernetes

### CLI

Test your Kubernetes cluster is up and running:

``` bash
kubectl get nodes
```

The output should look something like this:

``` bash
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

``` bash
kubectl proxy
```

Then open a web browser and navigate to:
[http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)

## Need to Start Over?

Did something go wrong? Nodes fail some process or not joined to the cluster? Break Docker Versions with apt-update?

Try the process again from the beginning:

``` bash
ansible-playbook cleanup.yml
```

Wait for everything to run and then start again with:

```bash
ansible-playbook cluster.yml
```

Make sure to remove .cache if your ip addresses change.

## Where to Get Help

If you run into any problems please join our welcoming [Discourse](https://discourse.rak8s.io/) community. If you find a bug please open an issue and pull requests are always welcome.

## Etymology

[**rak8s**](https://rak8s.io) (pronounced rackets - /ˈrækɪts/)

Coined by [Kendrick Coleman](https://github.com/kacole2) on [13 Jan 2018](https://twitter.com/KendrickColeman/status/952242602690129921)

## References & Credits

These playbooks were assembled using a handful of very helpful guides:

* [K8s on (vanilla) Raspbian Lite](https://gist.github.com/alexellis/fdbc90de7691a1b9edb545c17da2d975) by [Alex Ellis](https://www.alexellis.io/)
* [Installing kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
* [kubernetes/dashboard - Access control - Admin privileges](https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges)
* [Install using the convenience script](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script)

A very special thanks to [**Alex Ellis**](https://www.alexellis.io/) and the [OpenFaaS](https://www.openfaas.com/) community for their assitance in answering questions and making sense of some errors.

## Media Coverage

* [Raspberry Pi Kubernetes Cluster - chrisshort.net](https://chrisshort.net/raspberry-pi-kubernetes-cluster/)
* [DevOps'ish 060: WTF Google, SRE in a Serverless World, DevOps Requires Rethinking Norms, Kubernetes...](https://devopsish.com/060/)
* [071: Susan Fowler, Open Offices, Tech Debt, Cloud Native Serverless, Kubernetes, and More](https://devopsish.com/071/)
* [073: DevOps Hiring Guide, RIP RTFM, BGP & DNS, Kubernetes, GitLab, and More](https://devopsish.com/073/)
* [Building A Kubernetes Raspberry Pi3 Cluster With Rak8s And Ansible](http://nullendpoint.com/coding/2019/03/21/building-a-kubernetes-raspberry-pi3-cluster-with-rak8s-and-ansible/)
* [WOA Issue 37 - Armv8 Collaboration](https://www.worksonarm.com/blog/woa-issue-37/)
* [7 Raspberry Pi projects to explore](https://opensource.com/article/19/3/raspberry-pi-projects)
* [Running a Raspberry Pi cluster, a few months after - Alexandre Chaintreuil](http://achntrl.com/2018/11/05/running-a-kubernetes-cluster/)
