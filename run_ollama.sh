#!/bin/bash
# Save original stdout (fd 1) in fd 3
exec 3>&1
# Redirect all stdout to stderr
exec 1>&2

# Start ollama server (any output here goes to stderr)
nohup bash -c "ollama serve &"

# Wait for the server to start (messages go to stderr)
until curl -s http://127.0.0.1:11434 > /dev/null; do
    echo "Waiting for ollama to start..."
    sleep 1
done

# Generate response by passing the input to ollama run.
# (Any output by ollama run will go to stderr unless captured)
response=$(ollama run llama3.2:3b "$1")

# Now output ONLY the response line to original stdout using fd 3.
echo "Ollama Response: $response" >&3

# Exit the container after generating the response
exit 0
