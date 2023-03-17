#!/bin/bash

set -euxo pipefail

if [ ! -d community.windows ]; then
	mkdir -p community.windows
fi
pushd community.windows > /dev/null
ansible-galaxy collection download -vv -p . community.windows --no-deps
tar xfz community-windows-*.tar.gz \
    plugins/modules/win_domain_group.py \
    plugins/modules/win_domain_group.ps1 \
    plugins/modules/win_domain_user.py \
    plugins/modules/win_domain_user.ps1
rm community-windows-*.tar.gz
rm -f requirements.yml
popd > /dev/null
git add community.windows


