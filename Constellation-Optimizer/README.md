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
## AdaptiveConstellation vs. Basic Force-Optimized QAM

### Key Enhancements:

1. **Multi-Force System**  
   - Adds **central attraction force** (-β·r) to prevent boundary trapping  
   - Includes **controlled random noise** (η·randn) for local minima escape  
   - Maintains original **electrostatic repulsion** (1/r³)

2. **Dynamic Adaptation**  
   - Self-adjusts to constellation size (M)  
   - Automatically balances forces during optimization  
   - More robust convergence through noise injection

3. **Improved Stability**  
   - Triple protection against stuck points:  
     1. Repulsive inter-point forces  
     2. Central restoring force  
     3. Random perturbations  

4. **Physical Interpretation**  
   - Models a **damped electrostatic system**  
   - Analogous to:  
     - Particles in a potential well (central force)  
     - Thermal fluctuations (random noise)  

### When to Use Which:
| Feature          | Basic Version | AdaptiveConstellation |
|------------------|---------------|-----------------------|
| Boundary escape  | ❌ No         | ✅ Yes                |
| Force balance    | Manual        | Auto-adjusted         |
| Convergence      | Local optima  | Global-like           |
| Physical realism | Electrostatic | Thermodynamic         |
