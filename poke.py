#!/usr/bin/python3
import requests
import datetime
import os

# Retrieve Pokemon info
response = requests.get("https://pokeapi.co/api/v2/pokemon/staraptor")
data = response.json()

abilities = []
description = []

# Parse through Pokemon info and append the abilities' names to the abilities array
for ability in data['abilities']:
    ability_name = ability['ability']['name']
    abilities.append(ability_name)

# Fetching the description for each ability in a separate loop
for ability in data['abilities']:
    ability_response = requests.get(ability['ability']['url'])
    ability_data = ability_response.json()
    # Extracting the ability effect
    eng_response = next((entry['effect'] for entry in ability_data['effect_entries'] if entry['language']['name'] == 'en'), None)
    description.append(eng_response)

# Create finalized array
combined_array = []
for i in range(len(abilities)):
    ability_entry = abilities[i] + '\n'
    ability_description = description[i] + '\n' if description[i] is not None else '\n'
    combined_array.append(ability_entry)
    combined_array.append(ability_description)

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
