%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005


	global CL CD S m g rho	
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
							% Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
	CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + epsilon * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
	Gam		=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
	V		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam))));
							% Corresponding Velocity, m/s
	Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
	
%	a) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
    tspan	=	linspace(0,6,3000);
	xoNom	=	[3.55;Gam;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xoNom);
    xoLow   =   [2;Gam;H;R];
    [ta,xb]	=	ode23('EqMotion',tspan,xoLow);
    xoHigh  =   [7.5;Gam;H;R];
    [ta,xc]	=	ode23('EqMotion',tspan,xoHigh);
	
	
	figure
    subplot(2,1,1)
	plot(xa(:,4),xa(:,3),xb(:,4),xb(:,3),xc(:,4),xc(:,3),"lineWidth",2)
    line_color = ["k" "r" "[0.4660 0.6740 0.1880]"];
    colororder(line_color)
	xlabel('Range, m',"FontSize",15), ylabel('Height, m',"FontSize",15), grid
    title("Height vs range for various velocities","FontSize",17)
    legend("Nominal Velocity = 3.55 m/s", "Lower velocity = 2 m/s", "Higher velocity = 7.5 m/s","FontSize",17)




	xoNom	=	[V;-0.18;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xoNom);
    xoLow   =   [V;-0.5;H;R];
    [ta,xb]	=	ode23('EqMotion',tspan,xoLow);
    xoHigh  =   [V;0.4;H;R];
    [ta,xc]	=	ode23('EqMotion',tspan,xoHigh);


    subplot(2,1,2)
    plot(xa(:,4),xa(:,3),xb(:,4),xb(:,3),xc(:,4),xc(:,3),"lineWidth",2)
    line_color = ["k" "r" "[0.4660 0.6740 0.1880]"];
    colororder(line_color)
	xlabel('Range, m',"FontSize",15), ylabel('Height, m',"FontSize",15), grid
    title("Height vs range for various flight path angles","FontSize",17)
    legend("Nominal flight path angle = -0.18 rad", "Lower flight path angle = -0.5 rad", "Higher flight path angle = 0.4 rad","FontSize",17)
    ylim([-3 4])


    figure
    hold on

    vMin = 2;
    vMax = 7.5;
    gamMin = -0.5;
    gamMax = 0.4;

    megaTa = [];
    megaXa = [];

    for i = 1:100
        V = vMin + rand * (vMax-vMin);
        gam = gamMin + rand * (gamMax-gamMin);
        xo = [V;gam;H;R];
        [ta,xa]	=	ode23('EqMotion',tspan,xo);
        plot(xa(:,4),xa(:,3),"Color","k","LineWidth",0.3,"HandleVisibility","off")
        megaTa = [megaTa;ta];
        megaXa = [megaXa;xa];
    end
    

    polyOrder = 6;
    

    pRange = polyfit(megaTa,megaXa(:,4),polyOrder);
    pHeight = polyfit(megaTa,megaXa(:,3),polyOrder);

    yRange = polyval(pRange,tspan);
    yHeight = polyval(pHeight,tspan);
    hold on
    plot(yRange,yHeight,"LineWidth",2,"Color","Blue","HandleVisibility","off")
    plot(NaN,"DisplayName","Random generated initial conditions","Color","k","LineWidth",2)
    plot(NaN,"DisplayName","Polynomial fit","Color","Blue","LineWidth",2)
    legend("FontSize",15)
    title("Height vs Range for random generated initial conditions","FontSize",15)
    xlabel("Range (m)","FontSize",15)
    ylabel("Height (m)","FontSize",15)
    xlim([0 25])
    
    figure   
    plot(tspan,yRange,"LineWidth",2);
    xlabel('time, s',"FontSize",15), ylabel('Range, m',"FontSize",15), grid
    title("Average range vs time for gamma and velocity within expected values","FontSize",15)

    figure
    plot(tspan,yHeight,"LineWidth",2);
    xlabel('time, s',"FontSize",15), ylabel('Height, m',"FontSize",15), grid
    title("Average height vs time for gamma and velocity within expected values","FontSize",15)
    


    deltaRange = diff(yRange);
    deltaHeight = diff(yHeight);
    deltaT = diff(tspan);

    figure
    axis square
    subplot(2,1,1)
    plot(tspan(1,1:(end-1)),deltaRange ./ deltaT,"LineWidth",2)
    title("Change in range with respect to time vs time","FontSize",15)
    xlabel("time, s","FontSize",15)
    ylabel("Change in Range with respect to time, m/s","FontSize",13)

    subplot(2,1,2)
    plot(tspan(1,1:(end-1)),deltaHeight ./ deltaT,"LineWidth",2)
    title("Change in height with respect to time vs time","FontSize",15)
    xlabel("time, s","FontSize",15)
    ylabel("Change in height with respect to time, m/s","FontSize",13)
    

