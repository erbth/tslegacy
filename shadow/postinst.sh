#!/bin/bash

set -e

# Enable shadow passwords
pwconv -R "${TPM_TARGET}"
grpconv -R "${TPM_TARGET}"
