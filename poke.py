import requests
import datetime

# Retrieve Pokemon info
response = requests.get("https://pokeapi.co/api/v2/pokemon/staraptor")
data = response.json()

moveset = []
description = []

# Parse through pokemon info and append the abilities NAME to the moveset array
for move in data['abilities']:
    moveset.append(move['ability']['name'])

    # Fetching the description for each ability
    ability_response = requests.get(move['ability']['url'])
    ability_data = ability_response.json()
    eng_response = next((entry['effect'] for entry in ability_data['effect_entries'] if entry['language']['name'] == 'en'), None)
    description.append(eng_response)

# Create finalized array
combined_array = []
for i in range(len(moveset)):
    combined_array.append(moveset[i])
    combined_array.append('\n')
    combined_array.append(description[i])
    combined_array.append('\n')

# Create unique filename
timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
unique_filename = f"staraptor_{timestamp}.txt"

# Write to file
with open(unique_filename, 'w') as file:
    file.writelines(combined_array)

# Check if file is created
if os.path.exists(unique_filename):
    print("File created successfully.")
else:
    print("File creation failed or the file does not exist.")