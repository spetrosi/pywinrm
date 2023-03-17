#!/bin/bash

set -euxo pipefail

if [ ! -d ansible.windows ]; then
	mkdir -p ansible.windows
fi
pushd ansible.windows > /dev/null
ansible-galaxy collection download -vv -p . ansible.windows
tar xfz ansible-windows-*.tar.gz \
    plugins/modules/win_shell.py \
    plugins/modules/win_shell.ps1
rm ansible-windows-*.tar.gz
rm -f requirements.yml
popd > /dev/null
git add ansible.windows
