#!/bin/bash
# Initialize Hermes config from environment variables before s6 starts

HERMES_HOME="${HERMES_HOME:-/opt/data}"

# Only initialize on first run (check if config.yaml exists)
if [ ! -f "$HERMES_HOME/config.yaml" ]; then
    echo "Initializing Hermes config..."
    mkdir -p "$HERMES_HOME"

    cat > "$HERMES_HOME/config.yaml" << 'EOF'
# Hermes configuration - initialized from env vars
gateway:
  model: ${HERMES_GATEWAY_MODEL}
  provider: ${HERMES_GATEWAY_PROVIDER:-openrouter}
  
  platforms:
    discord:
      enabled: true
      bot_token: ${DISCORD_BOT_TOKEN:-}
      application_id: ${DISCORD_APP_ID:-}
    slack:
      enabled: ${SLACK_BOT_TOKEN:+true}
      bot_token: ${SLACK_BOT_TOKEN:-}
      signing_secret: ${SLACK_SIGNING_SECRET:-}
    telegram:
      enabled: ${TELEGRAM_BOT_TOKEN:+true}
      bot_token: ${TELEGRAM_BOT_TOKEN:-}
    whatsapp:
      enabled: false
    sms:
      enabled: false

  mcp_servers:
    atlassian:
      type: stdio
      command: npx
      args:
        - "-y"
        - "@anthropic/mcp-server-atlassian"
    gbrain:
      type: stdio
      command: gbrain
      args:
        - "mcp"
    hubspot:
      type: stdio
      command: npx
      args:
        - "-y"
        - "@anthropic/mcp-server-hubspot"
    slack:
      type: stdio
      command: npx
      args:
        - "-y"
        - "@anthropic/mcp-server-slack"

auxiliary:
  vision:
    provider: openrouter
    model: google/gemini-2.5-flash
EOF

    echo "Config initialized"
else
    echo "Config already exists, skipping init"
fi

# Continue with the original entrypoint
exec /init
