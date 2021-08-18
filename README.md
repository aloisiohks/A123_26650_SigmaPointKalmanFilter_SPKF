# A123_26650_SPKF
This repository contains the sigma-point Kalman filter (SPKF) algorithm for state of charge and temperature estimation for the A123 26650 m1b cell developed and used in the following publications

<a href="https://mountainscholar.org/handle/10976/167269">Kawakita de Souza, A. (2020). Advanced Predictive Control Strategies for Lithium-Ion Battery Management Using a Coupled Electro-Thermal Model [Master thesis, University of Colorado, Colorado Springs]. ProQuest Dissertations Publishing.</a>

<a href="https://ieeexplore.ieee.org/document/9483433">M. A. Xavier, A. K. de Souza and M. S. Trimboli, "An LPV-MPC Inspired Battery SOP Estimation Algorithm Using a Coupled Electro-Thermal Model," 2021 American Control Conference (ACC), 2021, pp. 4421-4426, doi: 10.23919/ACC50511.2021.9483433.</a>

-The underlying model of the SPKF algorithm is a coupled electro-thermal (CET) model developed in thesis above. The details of the CET model is presented below.<br/>
-The SPKF algorithm uses the current (ik), voltage (vk) and surface temperature (Ts,k) sensor measurements to make corrections on the SOC (zk) and temperature (Tc,k) estimates. See details below

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_1.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_1.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_2.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_2.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_3.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_3.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_1.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_55.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_3.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_6.png" width="900" height="400"/></a>
</p>

References:<br/>
[1] G. L. Plett, Battery Management Systems, Volume 1: Battery Modeling. Artech House, 2015.<br/>
[2] X. Lin, H. E. Perez, S. Mohan, J. B. Siegel, A. G. Stefanopoulou,Y. Ding, and M. P. Castanier, “A lumped-parameter electro-thermal model for cylindrical batteries,”Journal of PowerSources, vol. 257, pp. 1–11, Jul. 2014.<br/>
[3] G. L. Plett, Battery Management Systems, Volume 2: Equivalent-Circuit Methods. Artech House, 2015.<br/>
