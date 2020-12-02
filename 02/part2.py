# Open the file
f = open("day2.txt", "r")

# Read the file
input = f.read().split('\n')

# Set the values
invalid = 0
valid = 0

# Loop through each row
for row in input:
    # Get the details out
    min = int(row.split('-')[0])-1
    max = int(row.split('-')[1].split(' ')[0])-1
    char = row.split(' ')[1].split(':')[0]
    password = row.split(':')[1].strip()

    num_matches = 0
    if password[min] == char:
        num_matches += 1
    if password[max] == char:
        num_matches += 1
    if num_matches == 1:
        valid += 1

print(valid)
