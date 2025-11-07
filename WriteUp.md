
## Introduction

This lab focuses on using MATLAB to simulate and analyze the structural behavior of quadcopter frames under different loading conditions. The main goal is to understand how material choices and frame designs affect structural integrity and performance. In the first exercise, you'll test different materials (carbon fiber, aluminum, and plastic) to see how they respond to applied forces by measuring stress, strain, and deformation. The second exercise compares X-frame and H-frame configurations to determine which design handles motor thrust loads better. By the end of this lab, you'll know how to use MATLAB for structural simulation and make better design decisions based on material properties and frame geometry.


## Material Properties Simulation

### Question 1

_How does increasing the Young's Modulus (stiffer material) affect the beam's deformation?_

![Young_mod-matDeform.png](https://github.com/Flock137/IPS_Analytic_Lab_2/blob/main/Assets/Material%20Properties/Young_mod-matDeform.png)

The left panel shows Young's Modulus comparison across three materials, while the right panel displays the resulting deformation under the same 500N force. Increasing Young's Modulus significantly decreases deformation:

- Carbon Fiber (E = 70 GPa): 0.0143 mm
- Aluminum (E = 69 GPa): 0.0145 mm
- Plastic (E = 2.1 GPa): 0.4762 mm

Carbon fiber and aluminum show high (~70 GPa) stiffness but low of deformation. Plastic shows the opposite: a short stiffness bar (~2 GPa) but dominates the deformation chart at 0.5 mm. Plastic, with 33 times lower stiffness, deforms 33 times more under the same load because deformation is inversely proportional to Young's Modulus (δ = (σ/E) × L). This demonstrates why high-modulus materials are essential for structural applications requiring minimal flex.

### Question 2

_What impact does increasing the applied force have on the stress and deformation?_

![carbon_fiber.png](https://github.com/Flock137/IPS_Analytic_Lab_2/blob/main/Assets/Material%20Properties/carbon_fiber.png)

Both line plots show perfectly linear behavior. Stress and deformation increase linearly with applied force:

|Force (N)|Stress (MPa)|Deformation (mm)|
|---|---|---|
|100|0.4|0.0029|
|300|1.2|0.0086|
|500|2.0|0.0143|
|700|2.8|0.0200|
|1000|4.0|0.0286|

The straight-line plots confirm textbook linear behavior - doubling force doubles both stress and deformation. It follows Hooke's Law and shows carbon fiber remains in its elastic region across this force range. This predictability is useful for design since the response can be calculated at any load through simple multiplication. However, this only holds until the material reaches yield strength.

### Question 3

_Compare the deformation of the beam when using Carbon Fiber versus Plastic. Which material deforms less, and why?_

![[[Deform-Young_modulus.png](https://github.com/Flock137/IPS_Analytic_Lab_2/blob/main/Assets/Material%20Properties/Deform-Young_modulus.png)]]
Carbon fiber deforms **33.33 times less** than plastic:

- **Carbon Fiber**: 0.0143 mm
- **Plastic**: 0.4762 mm

The reason is the enormous stiffness gap shown in the right panel - Carbon Fiber (70 GPa) vs Plastic (2.1 GPa), a 33x ratio. Since deformation is inversely proportional to Young's Modulus, a material with 1/33rd the stiffness experiences 33x the deformation. For quadcopter frames, plastic would cause excessive flexing, poor control, vibrations, and potential failure. Carbon fiber's better stiffness makes it the clear choice for aerospace applications despite higher cost.

### Question 4

_How does changing the beam's thickness or width influence the stress distribution and overall structural behavior?_

![[material_strength_compare.png]]

![[width-thickness_onStress.png]]

The tensile strength chart shows Carbon Fiber (500 MPa) and Aluminum (310 MPa) far exceed Plastic (40 MPa). The two stress curves demonstrate inverse relationships - both curve downward hyperbolically as dimensions increase.

**Effect of Thickness** (width = 0.05m):

|Thickness (mm)|Stress (MPa)|Deformation (mm)|
|---|---|---|
|3|3.33|0.0238|
|5|2.00|0.0143|
|7|1.43|0.0102|
|10|1.00|0.0071|

**Effect of Width** (thickness = 0.005m):

|Width (mm)|Stress (MPa)|Deformation (mm)|
|---|---|---|
|30|3.33|0.0238|
|50|2.00|0.0143|
|70|1.43|0.0102|
|100|1.00|0.0071|

Both show identical patterns with more than three times of stress reduction across the range. This confirms stress is inversely proportional to cross-sectional area ($\sigma = F/A$). Doubling either dimension halves stress and deformation. The curves flatten at larger dimensions showing diminishing returns. For design, increasing dimensions reduces stress but adds weight and cost, and us - engineers - must balance these trade-offs.

## Frame Design and Simulation

### Question 1

_Frame Type Comparison - How does the X-frame compare to the H-frame in terms of deformation under the same applied forces? Which configuration appears to be more stable, and why?_

![[H_frame.png]]

![[X_frame.png]]

The H-frame is significantly more stable, showing 64.6% less deformation at 20N per motor:

- **X-frame**: 7.97 mm displacement
- **H-frame**: 2.82 mm displacement
- **Ratio**: X-frame deforms 2.83x more

This is purely geometric. The X-frame's diagonal motors create 0.566m effective arms (√2 × 0.4m) while the H-frame has 0.4m vertical arms. Since deflection follows δ ∝ L³, the X-frame's 1.41x longer arms cause 2.83x more deformation (1.41³ ≈ 2.8). The visualizations show both frames deflect inward and downward at motor points, but the X-frame's displacement is nearly three times larger. This makes the H-frame better for precise control, sensor stability, and payload carrying.

### Question 2

_Effect of Motor Force - What happens to the deformation of the frame when you increase the motor force? At what point do you think the structural integrity of the frame could be compromised?_

![[deform_motorF.png]]

Frame deformation increases linearly with motor force - doubling thrust doubles deflection:

|Force (N)|X-frame (mm)|H-frame (mm)|Stress (MPa)|Safety Factor|
|---|---|---|---|---|
|5|1.99|0.70|9.8|50.98|
|20|7.97|2.82|39.2|12.75|
|40|15.94|5.64|78.5|6.37|
|50|19.93|7.04|98.1|5.10|
|60|23.91|8.45|117.7|4.25|

The stress plot shows actual stress (green) staying well below yield strength (500 MPa red line) even at 60N (safety factor 4.25). However, structural integrity would be compromised around 50-60N not from material failure but excessive deformation. At 60N, the X-frame deflects 24mm - this would cause vibrations, reduced control precision, sensor errors, and potential oscillations. While the frame survives up to ~250N before yielding, practical limits occur much earlier. Staying below 40-50N per motor (safety factor > 6, deformation < 16mm) is advisable.

### Question 3

_Impact of Frame Dimensions - How do changes in the arm length or width of the frame impact the load distribution and deformation? Which design choices minimize deformation while maintaining structural strength?_

![[frame_deformation.png]]

**Arm Length Impact (X-frame):**

Cubic effect on arm deformation (L³ relationship):

|Arm Length (m)|Displacement (mm)|Increase Factor|
|---|---|---|
|0.2|1.00|1x (baseline)|
|0.3|3.36|3.4x|
|0.4|7.97|8.0x|
|0.5|15.57|15.6x|
|0.6|26.90|27.0x|

The exponential growth curve shows why minimizing arm length is crucial. Reducing arms from 0.6m to 0.3m cuts deformation by a factor of 8 - this is the single most powerful design lever for improving structural rigidity.

**Width Impact (H-frame):**

Width has no effect on vertical deformation - the plot shows a perfectly flat line at 2.82mm across all widths (0.05m to 0.25m). This is because width doesn't change the cantilever arm length; motors remain 0.4m away vertically regardless of horizontal spacing.

However, width improves stability through increased moment arms:

- Width = 0.05m → Stability arm = 0.10m (left-right motor spacing)
- Width = 0.25m → Stability arm = 0.50m (5x improvement)

Larger width provides better roll/pitch control authority, helping the quadcopter resist and correct rotational disturbances more effectively.

**Optimal Design Strategy:**

1. **Minimize arm length** - Shortest arms that still provide adequate motor clearance and component space
2. **Maximize width** - Widest practical spacing for enhanced control authority without aerodynamic penalties
3. **Balance trade-offs** - Very short arms may limit payload volume; very wide frames increase drag and reduce portability

The ideal configuration uses the minimum arm length necessary (around 0.3-0.35m) combined with maximized width (0.15-0.20m) to achieve both rigidity and excellent control characteristics.


### Question 4

_Design Recommendation - Based on your observations, which frame type and dimensions would you recommend for a quadcopter design that prioritizes stability and minimal deformation? Explain your reasoning using the results from the simulations._

![[deform_stability.png]]

Recommendation: H-frame with Arm Length = 0.35m and Width = 0.15m

This configuration provides the optimal balance of structural rigidity, control authority, and practical utility based on the following analysis:

**Comparison of Key Configurations:**

|Configuration|Displacement (mm)|Stability Arm (m)|Performance Ratio|
|---|---|---|---|
|X-frame, L=0.3m|3.36|0.424|0.13|
|X-frame, L=0.4m|7.97|0.566|0.07|
|H-frame, L=0.3m, W=0.1m|1.19|0.100|0.08|
|H-frame, L=0.3m, W=0.15m|1.19|0.150|**0.13**|
|H-frame, L=0.4m, W=0.15m|2.82|0.150|0.05|

**Reasoning:**

1. **Structural Rigidity**: The H-frame demonstrates 2.83x less deformation than an equivalent X-frame. This translates directly to better sensor stability, reduced vibrations, and more precise flight control.

2. **Control Authority**: The 0.15m width provides a 0.30m moment arm between left/right motors - this gives strong roll control for aggressive maneuvers and quick disturbance rejection while avoiding the diminishing returns and added drag of wider configurations.

3. **Optimal Size Trade-off**: While the L=0.3m, W=0.15m H-frame achieves the best performance ratio (0.13), extending to 0.35m arm length provides crucial benefits:
    - More interior space for battery, flight controller, and payload mounting
    - Better prop clearance from the frame
    - Only modest deformation penalty (~1.8mm estimated vs. 1.19mm)

4. **Robust Safety Margins**: At 20N per motor, this design maintains:
    - Deformation < 2mm (minimal flex)
    - Stress << 40 MPa (safety factor > 10)
    - Ample margin for dynamic loads, gusts, and maneuvers

5. **Practical Advantages**:
    - Rectangular geometry simplifies component mounting and wiring
    - Flat sides accommodate larger batteries and cameras
    - Straight arms are easier to manufacture and repair than angled X-frame arms
    - Better protection of center components during hard landings

**Trade-offs**: The H-frame has a slightly larger footprint than a compact X-frame, which may reduce portability. However, the substantial structural and control benefits far outweigh this minor inconvenience for most applications.

## Conclusion

This lab provided hands-on experience in analyzing quadcopter frame structures using MATLAB simulations. Key findings: carbon fiber deforms 33x less than plastic due to superior Young's Modulus; stress and deformation scale linearly with force; H-frame offers 2.83x better rigidity than X-frame due to shorter arms; arm length affects deformation cubically while width enhances control authority.

The skills developed - simulation setup, result interpretation, parameter identification, and evidence-based recommendations - apply broadly across engineering. Most importantly, computational simulation enables exploring design alternatives and optimizing configurations before building prototypes, saving time and money. The recommended H-frame design (L=0.35m, W=0.15m) emerged from systematic analysis, providing optimal balance of rigidity, control authority, and practical utility for real-world quadcopter applications.


## Appendix: MATLAB scripts

1. [Material Properties Simulation Adjusted Code](https://github.com/Flock137/IPS_Analytic_Lab_2/blob/main/Matlab/MaterialProperties.m)
2. [Frame Design and Simulation Adjusted Code](https://github.com/Flock137/IPS_Analytic_Lab_2/blob/main/Matlab/FrameDesign.m)
