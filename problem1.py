import matplotlib.pyplot as plt
import numpy as np

# Given parameters
supply_voltage = 5  # V
stall_current = 0.2  # A
free_running_current = 0.05  # A
free_running_rpm = 5000

# Calculate winding resistance
winding_resistance = supply_voltage / stall_current

# Calculate back-EMF at free-running speed
# Assuming no load, back-EMF is almost equal to supply voltage
back_emf_free_running = supply_voltage - (free_running_current * winding_resistance)

# Generate RPM values
rpm_values = np.arange(0, 5500, 500)

# Calculate back-EMF for each RPM
back_emf_values = (rpm_values / free_running_rpm) * back_emf_free_running

# Calculate current, electrical power, mechanical power, and total power
current_values = (supply_voltage - back_emf_values) / winding_resistance
electrical_power_values = current_values ** 2 * winding_resistance
mechanical_power_values = back_emf_values * current_values
total_power_values = supply_voltage * current_values

# Plotting
plt.figure(figsize=(10, 6))

plt.plot(rpm_values, electrical_power_values, label='Electrical Power (W)')
plt.plot(rpm_values, mechanical_power_values, label='Mechanical Power (W)')
plt.plot(rpm_values, total_power_values, label='Total Power (W)')

plt.xlabel('RPM')
plt.ylabel('Power (W)')
plt.title('DC Motor Power vs. RPM')
plt.legend()
plt.grid(True)
plt.show()