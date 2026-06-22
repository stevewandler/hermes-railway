FROM nousresearch/hermes-agent:latest
CMD ["gateway", "run"]

# Copy skills
COPY skills/ /opt/hermes/skills-staging/

# Add init script
COPY 03-copy-skills.sh /etc/cont-init.d/03-copy-skills
RUN chmod +x /etc/cont-init.d/03-copy-skills
