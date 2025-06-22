# Force-Optimized QAM Constellation Design

This MATLAB implementation uses electrostatic repulsion principles to optimize QAM constellation layouts by maximizing inter-symbol distances.

## Key Features
- Physics-inspired force-directed placement
- Supports arbitrary constellation sizes (adjust `M` variable)
- Boundary-aware optimization ([-3,3] range)

## Performance Notes
The algorithm uses 10,000 iterations by default for thorough convergence. For faster testing:
1. Reduce `iter` in the main loop (e.g., 1000 iterations)
2. Increase the learning rate (e.g., change `0.01` to `0.05`)  
*Note: These changes may slightly reduce optimization quality*

## Usage
```matlab
% For quick testing (faster but less optimized):
iter = 1000; % Reduced from 10000
points = points + 0.05 * force; % Increased from 0.01
