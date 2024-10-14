#!/usr/bin/env bash
#
# Executable to update `install-bazelisk/action.yml`.
#
# Args:
#   $1: Path to the action file.

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "ERROR: Incorrect number of arguments" >&2
  exit 1
fi

action_file=$1

if [[ ! -f "${action_file}" ]]; then
    echo "ERROR: File ${action_file} does not exist" >&2
    exit 1
fi

latest_tag=$(curl -s https://api.github.com/repos/bazelbuild/bazelisk/releases/latest | grep -oP '(?<=^  "name": ")[^"]+')

sed -i "s/^    default:.*/    default: \"${latest_tag}\"/" "${action_file}"
