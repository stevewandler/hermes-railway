#!/usr/bin/env bash
# Copy skills to the Hermes config directory on container start
set -e

SKILLS_STAGING="/opt/hermes/skills-staging"
SKILLS_TARGET="/opt/hermes/profiles/default/skills"

if [ -d "$SKILLS_STAGING" ] && [ "$(ls -A $SKILLS_STAGING 2>/dev/null)" ]; then
    echo "[03-copy-skills] Copying skills..."
    mkdir -p "$SKILLS_TARGET"
    cp -r "$SKILLS_STAGING"/* "$SKILLS_TARGET"/
    echo "[03-copy-skills] Skills copied"
fi
