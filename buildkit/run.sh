#!/usr/bin/env sh

if [ -n "${GITHUB_TOKEN:-}" ]; then
	echo "Configuring GitHub CLI for git authentication..."
	gh auth setup-git
fi
