FROM nousresearch/hermes-agent:latest
CMD ["gateway", "run"]

# Copy skills
COPY skills/ /opt/hermes/skills-staging/

# Add init scripts
COPY 03-copy-skills.sh /etc/cont-init.d/03-copy-skills
COPY 04-config-gen.sh /etc/cont-init.d/04-config-gen
RUN chmod +x /etc/cont-init.d/03-copy-skills /etc/cont-init.d/04-config-gen