#!/bin/bash

# Start the ollama server in the background.
nohup bash -c "ollama serve &" >&2

until curl -s http://127.0.0.1:11434 > /dev/null; do
    echo "Waiting for ollama to start..." >&2
    sleep 1
done

# Generate the response (this output goes to stdout by default).
response=$(ollama run llama3.2:3b "$1")

# Print only the desired response to stdout.
echo "Ollama Response: $response"

exit 0