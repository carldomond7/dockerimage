#!/usr/bin/python3
import requests
import datetime
import os

# Retrieve Pokemon info
response = requests.get("https://pokeapi.co/api/v2/pokemon/staraptor")
data = response.json()

moveset = []
description = []

# Parse through pokemon info and append the moves NAME to the moveset array
for move in data['moves']:
    move_name = move['move']['name']
    moveset.append(move_name)

    # Fetching the description for each move
    move_response = requests.get(move['move']['url'])
    move_data = move_response.json()
    # Extracting the move effect
    eng_response = next((entry['effect'] for entry in move_data['effect_entries'] if entry['language']['name'] == 'en'), None)
    description.append(eng_response)

# Create finalized array
combined_array = []
for i in range(len(moveset)):
    combined_array.append(moveset[i] + ': ' + description[i] + '\n')

# Create unique filename
timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
unique_filename = f"staraptor_{timestamp}.txt"

# Write to file
with open(unique_filename, 'w', encoding='utf-8') as file:
    file.writelines(combined_array)

# Check if file is created
if os.path.exists(unique_filename):
    print("File created successfully.")
else:
    print("File creation failed or the file does not exist.")
