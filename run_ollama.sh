#!/bin/bash

# Start ollama server
nohup bash -c "ollama serve &"
until curl -s http://127.0.0.1:11434 > /dev/null; do
    echo "Waiting for ollama to start..."
    sleep 1
done

# Pass input string to ollama run command and generate response
response=$(ollama run llama3.2:3b "$1")

# Output the response
echo "Ollama Response: $response"

# Exit the container after generating the response
exit 0