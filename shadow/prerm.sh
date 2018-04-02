#!/bin/bash

set -e

# Enable shadow passwords
pwunconv -R "${TPM_TARGET}"
grpunconv -R "${TPM_TARGET}"
