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
    min = int(row.split('-')[0])
    max = int(row.split('-')[1].split(' ')[0])
    char = row.split(' ')[1].split(':')[0]
    password = row.split(':')[1].strip()

    count = password.count(char)
    if count >= min and count <= max:
        valid += 1

print(valid)
