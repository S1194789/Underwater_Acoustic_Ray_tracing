# 🌊 Underwater Acoustic Ray Tracing & Signal Localization

> A MATLAB/Python project exploring how **acoustic waves propagate underwater** and how **signal analysis and ray tracing** can be used for communication and source localization.  
> Conducted as part of the *Underwater Acoustics* course in the **Erasmus Mundus MIR Programme** at Université de Toulon.

---

## 🌍 Project Overview

This project studies the propagation of **sound waves in deep ocean environments**, focusing on:
- How sound speed varies with **depth, temperature, and salinity**
- How **ray trajectories** bend and reflect underwater
- How **signal arrival times** can be used to estimate **source position and seafloor depth**

It integrates both **MATLAB** and **Python** simulations to visualize ray paths, compute emission angles, and reconstruct source positions using **time delay** and **backpropagation** techniques.

---

## 📂 Repository Structure

| Path | Description |
|------|--------------|
| **Codes/** | Contains all simulation and analysis scripts |
| ├── `ray_tracing_simulation.m` | MATLAB code for ray trajectory computation using Snell’s law |
| ├── `emission_angle_solver.py` | Python script to calculate the optimal emission angle between two hydrophones |
| ├── `signal_analysis.m` | Processes receiver signals to extract first arrival times and time delays |
| ├── `backpropagation_heatmap.py` | Generates heatmaps for source localization using time-reversed signals |
| └── `utils/` | Helper functions (sound speed profile, numerical gradient, coordinate conversion) |
| **HW1_MIR_2425_UWA.pdf** | Homework 1 – Acoustic ray trajectory and emission angle calculations |
| **HW2_MIR_2425_UWA.pdf** | Homework 2 – Signal analysis, time delay, and backpropagation method |
| **Underwater_Acoustics_report_Kwon_Mukesh.pdf** | Final report combining Homework 1 & 2 with discussion and figures |
| **README.md** | Project documentation (you’re here!) |

---

## ⚙️ Methodology

### 1️⃣ Ray Tracing Simulation
- Modeled acoustic ray paths in both **Arctic Ocean** and **Mediterranean Sea**
- Implemented **Snell’s Law** to compute wave refraction through depth-dependent sound speed
- Determined emission angles for optimal communication between hydrophones
- Visualized elliptical ray trajectories due to linear sound speed gradients

### 2️⃣ Signal Analysis & Localization
- Processed received signals from **9 receivers** placed at different depths
- Extracted **first arrival times** to estimate sound source location
- Estimated seafloor depth (~352 m) using **time delay & Pythagorean relation**
- Applied **backpropagation** to refine source localization (found at ~985 m, 121 m)

---

## 📊 Key Results

| Objective | Result |
|------------|---------|
| Optimal emission angle (Arctic Ocean) | **6.38°** |
| Optimal emission angle (Mediterranean Sea) | **4.97°** |
| Ideal transmitter depth (Mediterranean) | **≈700 m (sound channel depth)** |
| Estimated seafloor depth (signal delay) | **≈352 m** |
| Source location (backpropagation) | **x = 985 m, z = 121 m** |

---

## 🧩 Tools & Technologies

- **MATLAB** – ray tracing simulation and signal delay analysis  
- **Python (NumPy, Matplotlib)** – numerical modeling & heatmap visualization  
- **Acoustic Theory** – Snell’s Law, ray curvature, reflection principles  
- **Data Analysis** – time delay estimation and error evaluation  

---

## 🎓 Learning Outcomes

| Area | Description |
|------|--------------|
| **Acoustics** | Understood underwater wave propagation and reflection principles |
| **Modeling** | Built sound speed profiles and simulated wave paths |
| **Signal Processing** | Extracted time delays from received signals |
| **Localization** | Estimated transmitter position using backpropagation |
| **Programming** | Combined MATLAB and Python for hybrid acoustic simulation |

---

## 👩‍🔬 Authors

**Hyejoo Kwon** & **Sadhasivam Mukesh**  
📍 *Erasmus Mundus Master’s in Marine & Maritime Intelligent Robotics (MIR)*  
🧑‍🏫 *Instructor: Prof. M. Saillard*  

📅 *Submitted: January 2025*  
🔗 [GitHub Repository](https://github.com/S1194789/Underwater_Acoustic_Ray_tracing)
