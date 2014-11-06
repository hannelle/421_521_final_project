421_521_final_project
=====================

Rice Bioe 421/521 Final Project

Project Abstract
=================

Team Buttered Toast will create a capacitive sensor that will accurately detect the relative distance of high dielectric constant bodies. There are two aims for the proposed system: 1) create a cylindrical capacitive sensor and 2) process the signal of capacitive changes from the sensor using a microcontroller to algorithmically sense the presence of high dielectric constant bodies. The first will be accomplished by creating a cylindrical sensor with stainless steel as the conductive plates and fiberglass as the insulating layer between the plates. The stainless steel rings will have an outer diameter of .875 inches for the inner plate and an inner diameter of .902 inches for the outer plate. The fiberglass will be .017 inches thick and will be placed between the two cylindrical plates to create one sensor of about 1 inch in height. 

The second aim of this project will be accomplished using a testing environment and an Arduino Uno. The testing environment will be a probe on each conductive plate of the sensor attached to a power source, an op-amp to amplify the signal as well as convert it to a voltage for processing, and the sensor will also connect to the Arduino Uno. The Uno will take a baseline, then detect if any raw incoming data deviates significantly from the baseline. If so, then a body of an increased dielectric constant (such as a glass of water or a human body) must have approached the capacitive sensor. The Uno will then turn on an LED (or some form of an alert) to indicate that a body is nearby. Buttered Toast expects to see an increase in capacitance as a body approaches. The relationship between dielectric constant and capacitance is described in the below equation (where C is capacitance, ε_r is the dielectric constant, d is the separation between the plates, and A is area of overlap of the two plates):

C=ε_r  A/4πd


Buttered Toast plans to accomplish Aim 1 by 11/7 and Aim 2 by 11/13. Buttered Toast then plans to create a stage of alerts based on thresholds of distances from the capacitive sensor, as well as finalize the prototype by 11/20. The code for this system will be finished and submitted by 12/2 so that the team can present the complete product by 12/4.
Applications of this sensor include detecting large bodies of water, which is the main constituent of the human body. Therefore the sensor can be used to detect the presence of human interaction with electronic interfaces. More specifically, the sensor will be develop as a safety detection mechanism for the R-ARM, a wheelchair mounted robotic reaching aid. The sensor will detect the presence of human impedance in the path of motion of the robotic arm and halt movement in order to provide safe operation.

Project Brainstorming
=================

Objective: To develop a capacitive based proximity sensor that can accurately detect the relative distance of high dielectric constant bodies. The sensor will need to not only detect changes in capacitance, but also relay a signal to a microprocessor to complete a desired action.

Application: Bodies with high dielectric constants will affect the capacitance of the sensor. One prominent example of a substance with a high dielectric constant is water, which makes up 65% of the human body. Therefore the sensor can be used to detect the presence of human interaction with electronic interfaces. More specifically, the sensor will be develop as a safety detection mechanism for the R-ARM, a wheelchair mounted robotic reaching aid. The sensor will detect the presence of human impedance in the path of motion of the robotic arm and halt movement in order to provide safe operation.

Hardware: 
-	Custom built capacitance sensor
-	Signal conditioning components (op amps, 555 chip, resistors…etc)
-	Arduino Uno controller
-	Red LED alert signal


