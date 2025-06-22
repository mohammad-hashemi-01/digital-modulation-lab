clc, clear, close all

M = 16;                 % Number of symbols
max_coord = 3;          % Square boundary [-3,3]
points = (rand(M, 2) - 0.5) * 2 * max_coord; % Random initial distribution

% Initial constellation
figure;
scatter(points(:,1), points(:,2), 'filled', 'r');
axis equal; grid on; title('Initial Random Constellation');
xlabel('\Phi_1'); ylabel('\Phi_2');
xlim([-max_coord max_coord]); ylim([-max_coord max_coord]);

% Optimization parameters
max_iter = 5000;
learning_rate = 0.05;
noise_strength = 0.5;
center_force_strength = 0.05;

% Force-directed constellation optimization
for iter = 1:max_iter
    for i = 1:M
        % Calculate repulsive forces
        force = [0 0];
        for j = 1:M
            if i ~= j
                diff = points(i,:) - points(j,:);
                dist = norm(diff) + 1e-9;
                force = force + diff / dist^3; % Repulsive force
            end
        end
        
        % Add central force and random noise
        central_force = -center_force_strength * points(i,:);
        random_force = noise_strength * (rand(1,2)-0.5);
        
        % Update position
        points(i,:) = points(i,:) + learning_rate * (force + central_force) + random_force;
        points(i,:) = max(min(points(i,:), max_coord), -max_coord);
    end
end

% Final optimized constellation
figure;
scatter(points(:,1), points(:,2), 'filled', 'b');
axis equal; grid on; 
title(sprintf('Optimized %d-QAM Constellation after %d iterations', M, max_iter));
xlabel('\Phi_1'); ylabel('\Phi_2');
xlim([-max_coord max_coord]); ylim([-max_coord max_coord]);