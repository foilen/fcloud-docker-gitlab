#!/bin/bash

set -e

/assets/update-permissions
chmod 2770 /var/opt/gitlab/git-data/repositories
/assets/wrapper
