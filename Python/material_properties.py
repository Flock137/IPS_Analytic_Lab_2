"""
Enhanced Python Script for Material Properties Simulation
This script answers all analysis questions systematically
"""

import numpy as np
import matplotlib.pyplot as plt

# Material Properties Definition
# Carbon Fiber
density_carbon = 1600  # kg/m^3
youngs_modulus_carbon = 70e9  # Pa
tensile_strength_carbon = 500e6  # Pa

# Aluminum
density_aluminum = 2700  # kg/m^3
youngs_modulus_aluminum = 69e9  # Pa
tensile_strength_aluminum = 310e6  # Pa

# Plastic (ABS)
density_plastic = 1020  # kg/m^3
youngs_modulus_plastic = 2.1e9  # Pa
tensile_strength_plastic = 40e6  # Pa

# Base Configuration
length_base = 0.5  # meters
width_base = 0.05  # meters
thickness_base = 0.005  # meters
force_base = 500  # N

# ========================================================================
# QUESTION 1: Effect of Young's Modulus on Deformation
# ========================================================================
print("=== QUESTION 1: Effect of Young's Modulus on Deformation ===\n")

materials = ['Carbon Fiber', 'Aluminum', 'Plastic']
youngs_moduli = np.array([youngs_modulus_carbon, youngs_modulus_aluminum, youngs_modulus_plastic])
tensile_strengths = np.array([tensile_strength_carbon, tensile_strength_aluminum, tensile_strength_plastic])

cross_section_area = width_base * thickness_base
stress_q1 = force_base / cross_section_area

deformations_q1 = np.zeros(3)

for i in range(3):
    strain = stress_q1 / youngs_moduli[i]
    deformations_q1[i] = strain * length_base
    print(f'{materials[i]}:')
    print(f'  Young\'s Modulus: {youngs_moduli[i]:.2e} Pa')
    print(f'  Stress: {stress_q1:.2e} Pa')
    print(f'  Strain: {strain:.6f}')
    print(f'  Deformation: {deformations_q1[i]:.6f} m ({deformations_q1[i]*1000:.4f} mm)\n')

# Plot for Question 1
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

ax1.bar(materials, youngs_moduli/1e9)
ax1.set_title('Young\'s Modulus Comparison')
ax1.set_xlabel('Material')
ax1.set_ylabel('Young\'s Modulus (GPa)')
ax1.grid(True, alpha=0.3)

ax2.bar(materials, deformations_q1*1000)
ax2.set_title('Deformation Comparison (Same Force)')
ax2.set_xlabel('Material')
ax2.set_ylabel('Deformation (mm)')
ax2.grid(True, alpha=0.3)

plt.tight_layout()

print("ANSWER Q1: Materials with HIGHER Young's Modulus deform LESS.")
print("Stiffness is inversely proportional to deformation.\n")

# ========================================================================
# QUESTION 2: Effect of Applied Force on Stress and Deformation
# ========================================================================
print("=== QUESTION 2: Effect of Applied Force on Stress and Deformation ===\n")

forces = np.array([100, 300, 500, 700, 1000])  # N
material_select = 'Carbon Fiber'  # Using Carbon Fiber for this analysis
E_selected = youngs_modulus_carbon

stresses_q2 = np.zeros(len(forces))
deformations_q2 = np.zeros(len(forces))

for i, force in enumerate(forces):
    stresses_q2[i] = force / cross_section_area
    strain = stresses_q2[i] / E_selected
    deformations_q2[i] = strain * length_base
    print(f'Force = {force:.0f} N:')
    print(f'  Stress: {stresses_q2[i]:.2e} Pa')
    print(f'  Deformation: {deformations_q2[i]:.6f} m ({deformations_q2[i]*1000:.4f} mm)\n')

# Plot for Question 2
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

ax1.plot(forces, stresses_q2/1e6, 'b-o', linewidth=2, markersize=8)
ax1.set_title(f'Stress vs Applied Force ({material_select})')
ax1.set_xlabel('Applied Force (N)')
ax1.set_ylabel('Stress (MPa)')
ax1.grid(True, alpha=0.3)

ax2.plot(forces, deformations_q2*1000, 'r-o', linewidth=2, markersize=8)
ax2.set_title(f'Deformation vs Applied Force ({material_select})')
ax2.set_xlabel('Applied Force (N)')
ax2.set_ylabel('Deformation (mm)')
ax2.grid(True, alpha=0.3)

plt.tight_layout()

print("ANSWER Q2: Both stress and deformation increase LINEARLY with applied force.")
print("Doubling the force doubles both stress and deformation.\n")

# ========================================================================
# QUESTION 3: Carbon Fiber vs Plastic Comparison
# ========================================================================
print("=== QUESTION 3: Carbon Fiber vs Plastic Comparison ===\n")

# Compare Carbon Fiber and Plastic
materials_q3 = ['Carbon Fiber', 'Plastic']
E_q3 = np.array([youngs_modulus_carbon, youngs_modulus_plastic])

stress_q3 = force_base / cross_section_area
deformations_q3 = np.zeros(2)

for i in range(2):
    strain = stress_q3 / E_q3[i]
    deformations_q3[i] = strain * length_base
    print(f'{materials_q3[i]}:')
    print(f'  Young\'s Modulus: {E_q3[i]:.2e} Pa')
    print(f'  Deformation: {deformations_q3[i]:.6f} m ({deformations_q3[i]*1000:.4f} mm)')
    print(f'  Stiffness Ratio: {E_q3[0]/E_q3[i]:.2f}\n')

ratio = deformations_q3[1] / deformations_q3[0]
print(f'Plastic deforms {ratio:.2f} times MORE than Carbon Fiber\n')

# Plot for Question 3
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

ax1.bar(materials_q3, deformations_q3*1000)
ax1.set_title('Deformation: Carbon Fiber vs Plastic')
ax1.set_xlabel('Material')
ax1.set_ylabel('Deformation (mm)')
ax1.grid(True, alpha=0.3)

ax2.bar(materials_q3, E_q3/1e9)
ax2.set_title('Young\'s Modulus: Carbon Fiber vs Plastic')
ax2.set_xlabel('Material')
ax2.set_ylabel('Young\'s Modulus (GPa)')
ax2.grid(True, alpha=0.3)

plt.tight_layout()

print("ANSWER Q3: Carbon Fiber deforms MUCH LESS than Plastic.")
print("Reason: Carbon Fiber has ~33x higher Young's Modulus (70 GPa vs 2.1 GPa)\n")

# ========================================================================
# QUESTION 4: Effect of Beam Dimensions (Thickness and Width)
# ========================================================================
print("=== QUESTION 4: Effect of Beam Dimensions on Stress ===\n")

# Using Carbon Fiber for this analysis
E_q4 = youngs_modulus_carbon

# Varying thickness
thicknesses = np.array([0.003, 0.005, 0.007, 0.010])  # meters
stresses_thickness = np.zeros(len(thicknesses))
deformations_thickness = np.zeros(len(thicknesses))

print(f'--- Effect of Thickness (Width = {width_base:.3f} m) ---')
for i, t in enumerate(thicknesses):
    area = width_base * t
    stresses_thickness[i] = force_base / area
    strain = stresses_thickness[i] / E_q4
    deformations_thickness[i] = strain * length_base
    print(f'Thickness = {t:.3f} m: Stress = {stresses_thickness[i]:.2e} Pa, '
          f'Deformation = {deformations_thickness[i]*1000:.4f} mm')

print()

# Varying width
widths = np.array([0.03, 0.05, 0.07, 0.10])  # meters
stresses_width = np.zeros(len(widths))
deformations_width = np.zeros(len(widths))

print(f'--- Effect of Width (Thickness = {thickness_base:.3f} m) ---')
for i, w in enumerate(widths):
    area = w * thickness_base
    stresses_width[i] = force_base / area
    strain = stresses_width[i] / E_q4
    deformations_width[i] = strain * length_base
    print(f'Width = {w:.3f} m: Stress = {stresses_width[i]:.2e} Pa, '
          f'Deformation = {deformations_width[i]*1000:.4f} mm')

print()

# Plot for Question 4
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

ax1.plot(thicknesses*1000, stresses_thickness/1e6, 'b-o', linewidth=2, markersize=8)
ax1.set_title('Effect of Thickness on Stress')
ax1.set_xlabel('Thickness (mm)')
ax1.set_ylabel('Stress (MPa)')
ax1.grid(True, alpha=0.3)

ax2.plot(widths*1000, stresses_width/1e6, 'r-o', linewidth=2, markersize=8)
ax2.set_title('Effect of Width on Stress')
ax2.set_xlabel('Width (mm)')
ax2.set_ylabel('Stress (MPa)')
ax2.grid(True, alpha=0.3)

plt.tight_layout()

print("ANSWER Q4: Increasing EITHER thickness OR width DECREASES stress.")
print("Stress is inversely proportional to cross-sectional area (A = width × thickness)")
print("Larger dimensions distribute the load better, reducing stress and deformation.\n")

# ========================================================================
# Summary Visualization
# ========================================================================
plt.figure(figsize=(10, 6))
plt.bar(materials, tensile_strengths/1e6)
plt.title('Tensile Strength Comparison of Materials')
plt.xlabel('Material')
plt.ylabel('Tensile Strength (MPa)')
plt.grid(True, alpha=0.3)
plt.tight_layout()

print("=== SUMMARY OF FINDINGS ===")
print("1. Higher Young's Modulus → Less Deformation (stiffer material)")
print("2. Higher Applied Force → Proportionally Higher Stress & Deformation")
print("3. Carbon Fiber is superior to Plastic (33x stiffer, deforms much less)")
print("4. Larger cross-section (width/thickness) → Lower stress & deformation")

plt.show()