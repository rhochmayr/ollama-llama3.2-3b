# Use the existing ollama Dockerfile as the base
FROM ollama/ollama

# Update and install necessary packages
RUN apt-get update && apt-get install -y wget curl

# Run ollama in the background so we can embed the model
RUN nohup bash -c "ollama serve &" && \
    until curl -s http://127.0.0.1:11434 > /dev/null; do \
        echo "Waiting for ollama to start..."; \
        sleep 5; \
    done && \
    ollama pull llama3.2:3b

EXPOSE 11434

# Set the environment variable for the ollama host
ENV OLLAMA_HOST=0.0.0.0

# Copy a script to start ollama and handle input
COPY run_ollama.sh /run_ollama.sh
RUN chmod +x /run_ollama.sh

# Set the entrypoint to the script
ENTRYPOINT ["/run_ollama.sh"]