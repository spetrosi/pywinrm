#!/bin/bash

set -euxo pipefail

if [ ! -d ansible.posix ]; then
	mkdir -p ansible.posix
fi
pushd ansible.posix > /dev/null
ansible-galaxy collection download -vv -p . ansible.posix
tar xfz ansible-posix-*.tar.gz \
    plugins/callback/debug.py \
    plugins/callback/profile_tasks.py \
    plugins/modules/mount.py \
    plugins/module_utils/__init__.py \
    plugins/module_utils/mount.py
rm ansible-posix-*.tar.gz
rm -f requirements.yml
popd > /dev/null
git add ansible.posix
