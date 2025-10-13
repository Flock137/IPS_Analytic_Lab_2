% MATLAB Script for Frame Design and Simulation

%% --- Step 1: Define the Frame Configuration ---
% Choose between 'X-frame' or 'H-frame' configurations
% Students can modify the frame type here
frame_type = 'X-frame'; % Options: 'X-frame', 'H-frame'

% Frame dimensions (meters)
arm_length = 0.4; % Length of the frame arms
width = 0.1; % Width of the H-frame (only applies to H-frame)

% Define node positions based on frame type
switch frame_type
    case 'X-frame'
        % X-frame configuration: symmetric arms at 45 degrees
        nodes = [0, 0;  % Center (body of the quadcopter)
            arm_length, arm_length;  % Front-right motor
            -arm_length, arm_length; % Front-left motor
            -arm_length, -arm_length; % Back-left motor
            arm_length, -arm_length]; % Back-right motor
        element_connectivity = [1, 2; 1, 3; 1, 4; 1, 5]; % Arms

    case 'H-frame'
        % H-frame configuration: straight horizontal and vertical arms
        nodes = [0, 0;  % Center (body of the quadcopter)
            width, arm_length; % Front-right motor
            -width, arm_length; % Front-left motor
            -width, -arm_length; % Back-left motor
            width, -arm_length]; % Back-right motor
        element_connectivity = [1, 2; 1, 3; 1, 4; 1, 5]; % Arms
end

% Plot the frame structure
figure;
hold on;
for i = 1:size(element_connectivity, 1)
    plot([nodes(element_connectivity(i, 1), 1), nodes(element_connectivity(i, 2), 1)], ...
        [nodes(element_connectivity(i, 1), 2), nodes(element_connectivity(i, 2), 2)], 'b-', 'LineWidth', 2);
end
plot(nodes(:, 1), nodes(:, 2), 'ro', 'MarkerFaceColor', 'r'); % Plot nodes
axis equal;
title([frame_type ' Design']);
xlabel('X-axis (m)');
ylabel('Y-axis (m)');
grid on;
hold off;

%% --- Step 2: Apply Forces (Simulating Flight Conditions) ---
% Define forces applied to each motor (representing thrust from motors in Newtons)
% For simplicity, assume all motors produce equal thrust
motor_force = 20; % Force applied by each motor (N)
forces = [0, 0; 0, motor_force; 0, motor_force; 0, motor_force; 0, motor_force]; % Force vector [Fx, Fy] for each node

% Calculate resulting moments and loads
% Assume the center node is fixed, forces are applied at the motors
deformations = zeros(size(nodes)); % Placeholder for deformations
displacements = forces(:, 2) / 100; % Simplified calculation for illustration

% Apply simplified displacements to simulate deformation (for visualization only)
deformed_nodes = nodes;
deformed_nodes(2:end, 2) = deformed_nodes(2:end, 2) - displacements(2:end);

%% --- Step 3: Visualization of Deformation ---
figure;
hold on;
% Plot original frame
for i = 1:size(element_connectivity, 1)
    plot([nodes(element_connectivity(i, 1), 1), nodes(element_connectivity(i, 2), 1)], ...
        [nodes(element_connectivity(i, 1), 2), nodes(element_connectivity(i, 2), 2)], 'b-', 'LineWidth', 2);
end
plot(nodes(:, 1), nodes(:, 2), 'ro', 'MarkerFaceColor', 'r'); % Original nodes

% Plot deformed frame
for i = 1:size(element_connectivity, 1)
    plot([deformed_nodes(element_connectivity(i, 1), 1), deformed_nodes(element_connectivity(i, 2), 1)], ...
        [deformed_nodes(element_connectivity(i, 1), 2), deformed_nodes(element_connectivity(i, 2), 2)], 'r--', 'LineWidth', 2);
end
plot(deformed_nodes(:, 1), deformed_nodes(:, 2), 'bo', 'MarkerFaceColor', 'b'); % Deformed nodes
legend('Original Frame', 'Deformed Frame');
title(['Deformation in ' frame_type ' Design']);
xlabel('X-axis (m)');
ylabel('Y-axis (m)');
axis equal;
grid on;
hold off;

%% --- Step 4: Load Distribution Analysis ---
% Summarize forces and resulting deformations for each motor
disp('Frame Design Analysis:');
disp(['Frame Type: ', frame_type]);
disp(['Motor Thrust: ', num2str(motor_force), ' N']);
disp('Resulting Displacements at Motors (Y-direction):');
disp(displacements(2:end)); % Display displacements at motors