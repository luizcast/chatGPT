#!/bin/bash

# Set the OpenAI API key
export OPENAI_API_KEY="YOUR_API_KEY_HERE"

# Set the model to use
MODEL="text-davinci-002"

# Welcome message
echo "Welcome to ChatGPT! Start chatting by typing your message below."

# Start the conversation loop
while true; do
    # Prompt the user for input
    read -p "> " MESSAGE

    # Send the input to ChatGPT and get the response
    RESPONSE=$(curl -s "https://api.openai.com/v1/completions" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d '{"model": "'"$MODEL"'", "prompt": "'"$MESSAGE"'", "temperature": 0.5, "max_tokens": 200}' \
        | jq -r '.choices[].text')

    # Check if the API request was successful
    if [ -z "$RESPONSE" ]; then
        echo "Error: Failed to get response from ChatGPT."
    else
        # Display the response to the user
        echo "ChatGPT: $RESPONSE"
    fi
done

