# rak8s (pronounced rackets - /ˈrækɪts/)

## Stand up a Raspberry Pi based Kubernetes cluster with Ansible

### Why?

Because Raspberry Pis are rad, Ansible is awesome, and Kubernetes is keen!

# Prerequisites

* Raspberry Pi 3 (3 or more)
* [Raspbian Lite](https://www.raspberrypi.org/downloads/raspbian/)
* Raspberry Pis should have static IPs (requirement for Kubernetes and Ansible inventory)
* Ability to SSH into all Raspberry Pis and escalate privileges with sudo
  * The pi user is fine just change its password
* [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html) 2.2 or higher

# Recommendations

* Since Raspbian Lite is being used it's recommended that the video memory of the Raspberry Pi 3s be set to its lowest setting (16 MB).

# References & Credits

These playbooks were assembled using a handful of very helpful guides:

* [K8s on (vanilla) Raspbian Lite](https://gist.github.com/alexellis/fdbc90de7691a1b9edb545c17da2d975) by [Alex Ellis](https://www.alexellis.io/)
* [Installing kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
* [kubernetes/dashboard - Access control - Admin privileges](https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges)
* [Install using the convenience script](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script)

A very special thanks to [**Alex Ellis**](https://www.alexellis.io/) and the [OpenFaaS](https://www.openfaas.com/) community for their assitance in answering questions and making sense of some errors.