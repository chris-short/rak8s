#!/bin/bash
TOKEN=$(kubectl -n kube-system describe secret kubernetes-dashboard | awk '$1=="token:"{print $2}')

echo "${TOKEN}" > ~/.kube/dashboard-token.txt
