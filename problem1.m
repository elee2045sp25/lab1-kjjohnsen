% Given parameters
supply_voltage = 5; % V
stall_current = 0.2; % A
free_running_current = 0.05; % A
free_running_rpm = 5000;

% Calculate winding resistance
winding_resistance = supply_voltage / stall_current;

% Calculate back-EMF at free-running speed
% Assuming no load, back-EMF is almost equal to supply voltage
back_emf_free_running = supply_voltage - (free_running_current * winding_resistance);

% Generate RPM values
rpm_values = 0:500:5500;

% Calculate back-EMF for each RPM
back_emf_values = (rpm_values / free_running_rpm) * back_emf_free_running;

% Calculate current, electrical power, mechanical power, and total power
current_values = (supply_voltage - back_emf_values) / winding_resistance;
electrical_power_values = current_values .^ 2 * winding_resistance;
mechanical_power_values = back_emf_values .* current_values;
total_power_values = supply_voltage .* current_values;

% Plotting
figure;
plot(rpm_values, electrical_power_values, 'DisplayName', 'Electrical Power (W)');
hold on;
plot(rpm_values, mechanical_power_values, 'DisplayName', 'Mechanical Power (W)');
plot(rpm_values, total_power_values, 'DisplayName', 'Total Power (W)');
hold off;

xlabel('RPM');
ylabel('Power (W)');
title('DC Motor Power vs. RPM');
legend('show');
grid on;
