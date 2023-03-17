#!/bin/bash

set -euxo pipefail

# 3.6 is required for ansible engine
# 3.9 is required for ansible-core on EL 8.7 9.1
# 3.11 is required for ansible-core on EL 8.8 and 9.2
PYTHON_VERSIONS="3.6 3.9 3.11"

rm -rf pywinrm*
for version in $PYTHON_VERSIONS; do
    sudo dnf install python${version} -y
    if [ ! -d pywinrm-${version} ]; then
          mkdir -p pywinrm-${version}
    fi
    pushd pywinrm-${version} > /dev/null
    virtualenv -p ${version} .venv-${version}
    . .venv-${version}/bin/activate
    pip download pywinrm
    deactivate
    rm -rf .venv-${version}
    popd > /dev/null
    git add pywinrm-${version}
done
