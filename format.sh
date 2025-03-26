#!/bin/bash

# (C) Copyright 2025, SECO Mind Srl
#
# SPDX-License-Identifier: Apache-2.0

check_only=false

# Function to display help
display_help() {
    echo "Usage: $0 [--check-only] [--help]"
    echo
    echo "Options:"
    echo "  --check-only    Run clang-format in check mode without making changes."
    echo "  --help          Display this help message."
    exit 0
}

# Parse flags
for arg in "$@"
do
    case $arg in
        --check-only)
            check_only=true
            shift # Remove --check-only from processing
            ;;
        --help)
            display_help
            shift # Remove --help from processing
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Use --help to display usage information."
            exit 1
            ;;
    esac
done

# This script should only be run in the clea_cpu_monitoring_zephyr folder
current_dir_name=$(basename "$PWD")
if [ "$current_dir_name" != "clea_cpu_monitoring_zephyr" ]; then
    echo "The formatter script should only be run in the clea_cpu_monitoring_zephyr folder."
    exit 1
fi

# Check if the environment and dependencies are ok
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
source .venv/bin/activate
pip install --upgrade pip
package_name="clang-format"
package_version="20.1.0"
installed_version=$((pip show $package_name | grep Version | awk '{print $2}') || true)
if [ "$installed_version" != "$package_version" ]; then
    pip install $package_name==$package_version
    if [ $? -ne 0 ]; then
        echo "Failed to install $package_name version $package_version."
        exit 1
    fi
fi

# Run clang-format
format_files=("app/src/*.c" "app/include/*.h")
if [ "$check_only" = true ]; then
    command="--dry-run -Werror"
else
    command="-i"
fi
for file_pattern in "${format_files[@]}"; do
    clang-format --style=file $command $file_pattern
    if [ $? -ne 0 ]; then
        exit 1
    fi
done
