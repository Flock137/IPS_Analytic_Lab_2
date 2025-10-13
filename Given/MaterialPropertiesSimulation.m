% MATLAB Script for Material Properties Simulation

% --- Step 1: Material Properties Definition ---
% Define material properties for different materials (Carbon Fiber, Aluminum, Plastic)

% Students can modify the following properties for different materials:
% Density (kg/m^3), Young's Modulus (Pa), and Tensile Strength (Pa)

%% Material: Carbon Fiber
density_carbon = 1600; % kg/m^3
youngs_modulus_carbon = 70e9; % Pa
tensile_strength_carbon = 500e6; % Pa

%% Material: Aluminum
density_aluminum = 2700; % kg/m^3
youngs_modulus_aluminum = 69e9; % Pa
tensile_strength_aluminum = 310e6; % Pa

%% Material: Plastic (ABS)
density_plastic = 1020; % kg/m^3
youngs_modulus_plastic = 2.1e9; % Pa
tensile_strength_plastic = 40e6; % Pa

%% --- Step 2: Frame Model and Force Application ---
% Define a simple 2D frame model (a single beam for simplicity)
length = 0.5; % Length of the frame element (meters)
width = 0.05; % Width of the frame element (meters)
thickness = 0.005; % Thickness of the frame element (meters)

% Force applied to the center of the beam
applied_force = 500; % N (students can change this value)

% Calculating cross-sectional area of the beam
cross_section_area = width * thickness; % m^2

%% --- Step 3: Stress Calculation ---
% Students can switch between materials by changing the Young's Modulus and Tensile Strength

% Select the material: Carbon Fiber
material = 'Carbon Fiber'; % Options: 'Carbon Fiber', 'Aluminum', 'Plastic'

switch material
    case 'Carbon Fiber'
        youngs_modulus = youngs_modulus_carbon;
        tensile_strength = tensile_strength_carbon;
    case 'Aluminum'
        youngs_modulus = youngs_modulus_aluminum;
        tensile_strength = tensile_strength_aluminum;
    case 'Plastic'
        youngs_modulus = youngs_modulus_plastic;
        tensile_strength = tensile_strength_plastic;
end

% Stress calculation (force / area)
stress = applied_force / cross_section_area;

% Strain calculation (stress / Young's Modulus)
strain = stress / youngs_modulus;

% Deformation of the beam
deformation = strain * length; % m

%% --- Step 4: Visualization ---
% Create a plot to visualize the deformation

x = linspace(0, length, 100); % Beam along the x-axis
y = zeros(size(x)); % Original beam along the x-axis (no deformation)

% Applying deformation to the beam (simple visualization)
deformed_y = y + deformation; % Add deformation to the y-values

% Plot the original and deformed shape
figure;
hold on;
plot(x, y, 'k-', 'LineWidth', 2); % Original beam
plot(x, deformed_y, 'r--', 'LineWidth', 2); % Deformed beam
legend('Original Shape', 'Deformed Shape');
title(['Deformation of the Beam (Material: ', material, ')']);
xlabel('Length of the Beam (m)');
ylabel('Deformation (m)');
grid on;
hold off;

%% --- Step 5: Stress Visualization ---
% Create a bar chart to compare material properties and stress

materials = {'Carbon Fiber', 'Aluminum', 'Plastic'};
stress_values = [tensile_strength_carbon, tensile_strength_aluminum, tensile_strength_plastic];

figure;
bar(stress_values);
set(gca, 'xticklabel', materials);
title('Tensile Strength Comparison of Materials');
xlabel('Material');
ylabel('Tensile Strength (Pa)');
grid on;
