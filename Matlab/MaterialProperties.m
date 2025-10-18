% Enhanced MATLAB Script for Material Properties Simulation
% This script answers all analysis questions systematically

clc; clear; close all;

%% Material Properties Definition
% Carbon Fiber
density_carbon = 1600; % kg/m^3
youngs_modulus_carbon = 70e9; % Pa
tensile_strength_carbon = 500e6; % Pa

% Aluminum
density_aluminum = 2700; % kg/m^3
youngs_modulus_aluminum = 69e9; % Pa
tensile_strength_aluminum = 310e6; % Pa

% Plastic (ABS)
density_plastic = 1020; % kg/m^3
youngs_modulus_plastic = 2.1e9; % Pa
tensile_strength_plastic = 40e6; % Pa

%% Base Configuration
length_base = 0.5; % meters
width_base = 0.05; % meters
thickness_base = 0.005; % meters
force_base = 500; % N

% ========================================================================
%% QUESTION 1: Effect of Young's Modulus on Deformation
% ========================================================================
fprintf('=== QUESTION 1: Effect of Young''s Modulus on Deformation ===\n\n');

materials = {'Carbon Fiber', 'Aluminum', 'Plastic'};
youngs_moduli = [youngs_modulus_carbon, youngs_modulus_aluminum, youngs_modulus_plastic];
tensile_strengths = [tensile_strength_carbon, tensile_strength_aluminum, tensile_strength_plastic];

cross_section_area = width_base * thickness_base;
stress_q1 = force_base / cross_section_area;

deformations_q1 = zeros(1, 3);

for i = 1:3
    strain = stress_q1 / youngs_moduli(i);
    deformations_q1(i) = strain * length_base;
    fprintf('%s:\n', materials{i});
    fprintf('  Young''s Modulus: %.2e Pa\n', youngs_moduli(i));
    fprintf('  Stress: %.2e Pa\n', stress_q1);
    fprintf('  Strain: %.6f\n', strain);
    fprintf('  Deformation: %.6f m (%.4f mm)\n\n', deformations_q1(i), deformations_q1(i)*1000);
end

% Plot for Question 1
figure('Position', [100, 100, 1200, 500]);
subplot(1,2,1);
bar(youngs_moduli/1e9);
set(gca, 'xticklabel', materials);
title('Young''s Modulus Comparison');
xlabel('Material');
ylabel('Young''s Modulus (GPa)');
grid on;

subplot(1,2,2);
bar(deformations_q1*1000);
set(gca, 'xticklabel', materials);
title('Deformation Comparison (Same Force)');
xlabel('Material');
ylabel('Deformation (mm)');
grid on;

fprintf('ANSWER Q1: Materials with HIGHER Young''s Modulus deform LESS.\n');
fprintf('Stiffness is inversely proportional to deformation.\n\n');

% ========================================================================
%% QUESTION 2: Effect of Applied Force on Stress and Deformation
% ========================================================================
fprintf('=== QUESTION 2: Effect of Applied Force on Stress and Deformation ===\n\n');

forces = [100, 300, 500, 700, 1000]; % N
material_select = 'Carbon Fiber'; % Using Carbon Fiber for this analysis
E_selected = youngs_modulus_carbon;

stresses_q2 = zeros(size(forces));
deformations_q2 = zeros(size(forces));

for i = 1:length(forces)
    stresses_q2(i) = forces(i) / cross_section_area;
    strain = stresses_q2(i) / E_selected;
    deformations_q2(i) = strain * length_base;
    fprintf('Force = %d N:\n', forces(i));
    fprintf('  Stress: %.2e Pa\n', stresses_q2(i));
    fprintf('  Deformation: %.6f m (%.4f mm)\n\n', deformations_q2(i), deformations_q2(i)*1000);
end

% Plot for Question 2
figure('Position', [100, 100, 1200, 500]);
subplot(1,2,1);
plot(forces, stresses_q2/1e6, 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
title(['Stress vs Applied Force (', material_select, ')']);
xlabel('Applied Force (N)');
ylabel('Stress (MPa)');
grid on;

subplot(1,2,2);
plot(forces, deformations_q2*1000, 'r-o', 'LineWidth', 2, 'MarkerSize', 8);
title(['Deformation vs Applied Force (', material_select, ')']);
xlabel('Applied Force (N)');
ylabel('Deformation (mm)');
grid on;

fprintf('ANSWER Q2: Both stress and deformation increase LINEARLY with applied force.\n');
fprintf('Doubling the force doubles both stress and deformation.\n\n');

% ========================================================================
%% QUESTION 3: Carbon Fiber vs Plastic Comparison
% ========================================================================
fprintf('=== QUESTION 3: Carbon Fiber vs Plastic Comparison ===\n\n');

% Compare Carbon Fiber and Plastic
materials_q3 = {'Carbon Fiber', 'Plastic'};
E_q3 = [youngs_modulus_carbon, youngs_modulus_plastic];

stress_q3 = force_base / cross_section_area;
deformations_q3 = zeros(1, 2);

for i = 1:2
    strain = stress_q3 / E_q3(i);
    deformations_q3(i) = strain * length_base;
    fprintf('%s:\n', materials_q3{i});
    fprintf('  Young''s Modulus: %.2e Pa\n', E_q3(i));
    fprintf('  Deformation: %.6f m (%.4f mm)\n', deformations_q3(i), deformations_q3(i)*1000);
    fprintf('  Stiffness Ratio: %.2f\n\n', E_q3(1)/E_q3(i));
end

ratio = deformations_q3(2) / deformations_q3(1);
fprintf('Plastic deforms %.2f times MORE than Carbon Fiber\n\n', ratio);

% Plot for Question 3
figure('Position', [100, 100, 1200, 500]);
subplot(1,2,1);
bar(deformations_q3*1000);
set(gca, 'xticklabel', materials_q3);
title('Deformation: Carbon Fiber vs Plastic');
xlabel('Material');
ylabel('Deformation (mm)');
grid on;

subplot(1,2,2);
bar(E_q3/1e9);
set(gca, 'xticklabel', materials_q3);
title('Young''s Modulus: Carbon Fiber vs Plastic');
xlabel('Material');
ylabel('Young''s Modulus (GPa)');
grid on;

fprintf('ANSWER Q3: Carbon Fiber deforms MUCH LESS than Plastic.\n');
fprintf('Reason: Carbon Fiber has ~33x higher Young''s Modulus (70 GPa vs 2.1 GPa)\n\n');

% ========================================================================
%% QUESTION 4: Effect of Beam Dimensions (Thickness and Width)
% ========================================================================
fprintf('=== QUESTION 4: Effect of Beam Dimensions on Stress ===\n\n');

% Using Carbon Fiber for this analysis
E_q4 = youngs_modulus_carbon;

% Varying thickness
thicknesses = [0.003, 0.005, 0.007, 0.010]; % meters
stresses_thickness = zeros(size(thicknesses));
deformations_thickness = zeros(size(thicknesses));

fprintf('--- Effect of Thickness (Width = %.3f m) ---\n', width_base);
for i = 1:length(thicknesses)
    area = width_base * thicknesses(i);
    stresses_thickness(i) = force_base / area;
    strain = stresses_thickness(i) / E_q4;
    deformations_thickness(i) = strain * length_base;
    fprintf('Thickness = %.3f m: Stress = %.2e Pa, Deformation = %.4f mm\n', ...
        thicknesses(i), stresses_thickness(i), deformations_thickness(i)*1000);
end
fprintf('\n');

% Varying width
widths = [0.03, 0.05, 0.07, 0.10]; % meters
stresses_width = zeros(size(widths));
deformations_width = zeros(size(widths));

fprintf('--- Effect of Width (Thickness = %.3f m) ---\n', thickness_base);
for i = 1:length(widths)
    area = widths(i) * thickness_base;
    stresses_width(i) = force_base / area;
    strain = stresses_width(i) / E_q4;
    deformations_width(i) = strain * length_base;
    fprintf('Width = %.3f m: Stress = %.2e Pa, Deformation = %.4f mm\n', ...
        widths(i), stresses_width(i), deformations_width(i)*1000);
end
fprintf('\n');

% Plot for Question 4
figure('Position', [100, 100, 1200, 500]);
subplot(1,2,1);
plot(thicknesses*1000, stresses_thickness/1e6, 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
title('Effect of Thickness on Stress');
xlabel('Thickness (mm)');
ylabel('Stress (MPa)');
grid on;

subplot(1,2,2);
plot(widths*1000, stresses_width/1e6, 'r-o', 'LineWidth', 2, 'MarkerSize', 8);
title('Effect of Width on Stress');
xlabel('Width (mm)');
ylabel('Stress (MPa)');
grid on;

fprintf('ANSWER Q4: Increasing EITHER thickness OR width DECREASES stress.\n');
fprintf('Stress is inversely proportional to cross-sectional area (A = width × thickness)\n');
fprintf('Larger dimensions distribute the load better, reducing stress and deformation.\n\n');

% ========================================================================
%% Summary Visualization
% ========================================================================
figure('Position', [100, 100, 1000, 600]);
bar(tensile_strengths/1e6);
set(gca, 'xticklabel', materials);
title('Tensile Strength Comparison of Materials');
xlabel('Material');
ylabel('Tensile Strength (MPa)');
grid on;

fprintf('=== SUMMARY OF FINDINGS ===\n');
fprintf('1. Higher Young''s Modulus → Less Deformation (stiffer material)\n');
fprintf('2. Higher Applied Force → Proportionally Higher Stress & Deformation\n');
fprintf('3. Carbon Fiber is superior to Plastic (33x stiffer, deforms much less)\n');
fprintf('4. Larger cross-section (width/thickness) → Lower stress & deformation\n');