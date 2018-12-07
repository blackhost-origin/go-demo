#!/bin/bash

#Example:
#
# docker run --rm \
#   hub.tencentyun.com/workshop/deploy
#

set -e
export SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

source $SCRIPTDIR/component-base/libs.sh

init_kubectl_config() {
	local tke_server=`hub_var TKE_SERVER true`
	local tke_username=`hub_default_var TKE_USERNAME admin`
	local tke_password=`hub_var TKE_PASSWORD true`

	hub_var TKE_CERTIFICATE true | tee -a /tke-cluster-ca.crt

	kubectl config set-credentials default-admin --username="$tke_username" --password="$tke_password"
	kubectl config set-cluster default-cluster --server="$tke_server" --certificate-authority=/tke-cluster-ca.crt
	kubectl config set-context default-system --cluster=default-cluster --user=default-admin
	kubectl config use-context default-system
}

do_task() {
	init_kubectl_config

	echo "ok"
}

do_task

