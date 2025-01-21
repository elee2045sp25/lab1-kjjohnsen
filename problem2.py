import pandas as pd
import matplotlib.pyplot as plt

# Load the cuts data
cuts = pd.read_csv("cuts.csv")

# Initialize variables
last_x = cuts.iloc[0, 0]
last_y = cuts.iloc[0, 1]
total_cut_distance = 0
total_travel_distance = 0

# Iterate over each row in the DataFrame
for index, row in cuts.iterrows():
    # Calculate the cutting distance for the current segment
    cut_distance = ((row.x2 - row.x1) ** 2 + (row.y2 - row.y1) ** 2) ** 0.5

    # Calculate the travel distance to the start of the current segment
    travel_distance = ((row.x1 - last_x) ** 2 + (row.y1 - last_y) ** 2) ** 0.5

    # Update total distances
    total_cut_distance += cut_distance
    total_travel_distance += travel_distance

    # Update the last position
    last_x = row.x2
    last_y = row.y2

    # Plot the current cut segment
    plt.plot([row.x1, row.x2], [row.y1, row.y2])

# Display the plot
plt.show()

# Calculate total distance and efficiency
total_distance = total_cut_distance + total_travel_distance
efficiency = (total_cut_distance / total_distance) * 100

# Print the efficiency and distances
print(f"{efficiency:.2f}% efficiency, {total_cut_distance} units cut, {total_distance} traveled.")
