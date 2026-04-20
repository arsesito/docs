#!/bin/bash
set -e

echo "Setting up SAOG environment..."
echo "Deno version:"
deno --version

echo "SAOG_READY=true" >> $GITHUB_ENV
echo "✓ SAOG environment ready!"