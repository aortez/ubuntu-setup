#!/bin/bash
# pushes local photos to s3 bucket
set -euxo pipefail

time aws s3 sync /home/data/Photos s3://ao_backup/Photos
