clc, clear, close all

M = 64;                 % Number of symbols (64-QAM)
max_coord = 3;          % Square boundary [-3,3]
points = (rand(M, 2) - 0.5) * 2 * max_coord; % Random initial distribution

% Initial constellation
figure;
scatter(points(:,1), points(:,2), 'filled', 'r');
axis equal; grid on; title('Initial Random Constellation');
xlabel('\Phi_1'); ylabel('\Phi_2');
xlim([-max_coord max_coord]); ylim([-max_coord max_coord]);

% Force-directed constellation optimization
for iter = 1:10000
    for i = 1:M
        force = [0 0];
        for j = 1:M
            if i ~= j
                diff = points(i,:) - points(j,:);
                dist = norm(diff) + 1e-9;
                force = force + diff / dist^3; % Repulsive force
            end
        end
        points(i,:) = points(i,:) + 0.01 * force;
        points(i,:) = max(min(points(i,:), max_coord), -max_coord);
    end
end

% Final optimized constellation
figure;
scatter(points(:,1), points(:,2), 'filled', 'b');
axis equal; grid on; title('Optimized 64-QAM Constellation');
xlabel('\Phi_1'); ylabel('\Phi_2');
xlim([-max_coord max_coord]); ylim([-max_coord max_coord]);
