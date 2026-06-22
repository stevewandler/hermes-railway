FROM nousresearch/hermes-agent:latest

# Override CMD to run gateway mode
CMD ["gateway", "run"]

# Copy skills to the default profile
COPY skills/ /opt/hermes/profiles/default/skills/

# Copy startup script that initializes config from env vars
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
