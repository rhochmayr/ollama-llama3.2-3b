#!/bin/bash

# Start ollama server and redirect logs to stderr
nohup bash -c "ollama serve &" 2>&1 1>/dev/null &
until curl -s http://127.0.0.1:11434 > /dev/null; do
    echo "Waiting for ollama to start..." >&2
    sleep 1
done

# Pass input string to ollama run command and generate response
response=$(ollama run llama3.2:3b "$1")

# Output the response to stdout
echo "Ollama Response: $response"

# Exit the container after generating the response
exit 0