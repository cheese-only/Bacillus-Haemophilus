# Bacillus-Haemophilus
An ODE-based mathematical model evaluating the ecological dynamics and evolutionary rationale of the "Cultivate-and-Harvest" strategy in Bacillus-Haemophilus co-cultures under resource dissipation and cheater invasion.

## 📌 Model Overview

This repository contains the mathematical modeling framework (ordinary differential equations, ODEs) developed for investigating the temporal population dynamics and evolutionary trade-offs in a *Bacillus*-*Haemophilus* interaction system.

The model addresses a counterintuitive ecological phenomenon: **Why does *Bacillus* invest costly metabolic resources (NAD secretion) early on to promote *Haemophilus* growth, only to louse and harvest its nutrients later?**

### Key Features & Findings：

1. **Strategy Comparison)**: 
   Compares a **Self-sustaining (Self)** strategy (direct resource consumption) against a **Cultivate-and-Harvest (Cult)** strategy (early NAD-mediated cultivation followed by late-phase population clearing).

2. **Resource Dissipation & Fixation**: 
   - Under constant nutrient supply, the Self strategy is globally optimal.
   - Under rapid nutrient decay (transient resource environments), the Cult strategy enables *Bacillus* to "race against time" by locking transient resources into *Haemophilus* biomass, which are subsequently reclaimed to fuel a distinct secondary growth phase.

3. **Broad-Spectrum Defense against Cheaters**: 
   In polymicrobial contexts, invading cheater species intercept harvested nutrients and abolish the Cult strategy's advantage. The model predicts that *Bacillus* must deploy a **broad-spectrum clearing mechanism**—eliminating both *Haemophilus* and invading cheaters—to co-opt cheater biomass into a transient resource reservoir, thereby rescuing the ecological advantage of the Cult strategy.
