# Final-project

  # Paper Airplane Numerical Study
  Final Project: AEM 3103 Spring 2024

  - By: Owen Constine

## Summary of Findings


**variations studied**

1) Initial Velocity

|Low|Nominal|High|
|---|---|---|
|2.0 m/s|3.55 m/s|7.5 m/s|

2) Initial Flight Path Angle
   
|Low|Nominal|High|
|---|---|---|
|-0.5 rad|-0.18 rad|0.4 rad|

In this study the Initial Velocity and Initial Flight path angles were changed and the trajectories were plotted which can be seen below.
For the nominal value of the starting flight path angle and velocity the trajectory is a straight and steady line. Whereas when increasing the flight path angle or velocity beyond nominal it will start climbing then enter a steeper descent and oscillate around the nominal trajectory. Decreasing the flight path angle or velocity beyond nominal also induces oscillations but it starts in a steeper descent. These oscillations are called phugoids. 

First only one parameter (Velocity or flight path angle) was adjusted at a time. The paths of which can be seen below. Then both parameters were adjusted as well as additional processing such as polynomial fitting and derivatives were taken.




**Code**

[EqMotion.m](EqMotion.m)    Basic function which the main project file uses. Has aircraft equations of motion embedded within the function

[project.m](project.m)      Uses EqMotion.m and creates desired plots and data for the project


# Figures



 ## Fig. 1: Single Parameter Variation
 ![](https://github.com/owen655/Final-project/assets/55365507/b8ac8c01-602a-4511-9ca8-b285cf0f2adc)

 This figure shows the trajectories of a glider after adjusting only one parameter at a time (Velocity or flight path angle) when adjusting one parameter the other parameter takes the nominal value.


 ## Fig. 2-4: Monte Carlo Simulation
 ![RandomValues](https://github.com/owen655/Final-project/assets/55365507/760eb621-77ec-48c9-9af8-d3b0956e6afa)

 This figure shows 100 unique trajectories. Each one has a randomly generated starting velocity and flight path angle within the low and high
 values which you can see in the table in the summary section. This figure also shows the curve fit polynomial in blue which was fitted to 
 the 100 trajectories.

 ![RangeVsTime](https://github.com/owen655/Final-project/assets/55365507/76461921-3ce6-4128-b707-030c8102efa8)

 This figure shows the Range vs Time for the polynomial curve fit trajectory which was previously described. Note) Although it appears to be 
 a straight line it is not. 

 ![HeightVsTime](https://github.com/owen655/Final-project/assets/55365507/5acc5f78-a775-4873-8081-44d22561e020)

This figure shows the Height vs Time for the polynomial curve fit trajectory which was previously described

 ## Fig. 5: Time Derivatives

 ![DeravitivePlot](https://github.com/owen655/Final-project/assets/55365507/9be7569b-39ff-4c90-9407-7ce6866c47d6)

 This figure shows two plots. The first one is the change in range with respect to time vs time (ie. the horizontal velocity vs time) of the polynomial fit trajectory. Note the scales on the y axis.
 
 The second plot on this figure shows the change in height with respect to time vs time (ie. the vertical velocity vs time) of the polynomial fit trajectory. 




 
   


 








   
   




