%hbar_flat_plate, 7/31/16, Andrew Sung. 
%Approximates average convection coefficient for a flat plate in steady, 
%forced external flow, with constant velocity and constant film
%temperature.

%Must account for crossflow

clear all
format compact

githubtest=1;

disp('Flat Plate External Convection for Air')
u=input('Enter Free Stream Velocity [m/s]:'); 
L=input('Enter Length of Plate [m]:');
tfs=input('Enter Free Stream Temperature [C]:')+273;
ts=input('Enter Surface Temperature[C]:')+273;
temp=(tfs+ts)/2; %film temperature

if 250>=temp %specifies acceptable temperature range
    display('NOTE: Mean Temperature must be in range -23C<T<102C')
elseif 375<=temp
    display('NOTE: Mean Temperature must be in range -23C<T<102C')
end

%Kinematic viscosity values
Viscval=[1.132e-5 1.343e-5 1.568e-5 1.807e-5 2.056e-5 2.317e-5]; %[visc(250) visc(275) visc(300) visc(325) visc(350) visc(375)]
%Prandtl number values
Prval=[.720 .713 .707 .701 .697 .692];
%Thermal conductivity values
kval=[2.227e-2 2.428e-2 2.624e-2 2.816e-2 3.003e-2 3.186e-2];

run=25;
if 250<temp<=275 %Runs linear interpolation based on table values
    
    rise=Viscval(2)-Viscval(1); %visc
    rise2=Prval(2)-Prval(1); %Pr
    rise3=kval(2)-kval(1); %k
    
    visc=(rise/run)*(temp-250)+Viscval(1); %kinematic viscosity
    Pr=(rise2/run)*(temp-250)+Prval(1);   %Prandtl Number
    k=(rise3/run)*(temp-250)+kval(1); %Thermal conductivity
    
elseif 275<temp<=300
    
    rise=Viscval(3)-Viscval(2);
    rise2=Prval(3)-Prval(2);
    rise3=kval(3)-kval(2); 
    
    visc=(rise/run)*(temp-275)+Viscval(2);
    Pr=(rise2/run)*(temp-275)+Prval(2); 
    k=(rise3/run)*(temp-275)+kval(2);
    
elseif 300<temp<=325
    
    rise=Viscval(4)-Viscval(3);
    rise2=Prval(4)-Prval(3);
    rise3=kval(4)-kval(3);
    
    visc=(rise/run)*(temp-300)+Viscval(3);
    Pr=(rise2/run)*(temp-300)+Prval(3);  
    k=(rise3/run)*(temp-300)+kval(3);
    
elseif 325<temp<=350
    
    rise=Viscval(5)-Viscval(4);
    rise2=Prval(5)-Prval(4);
    rise3=kval(5)-kval(4);
    
    visc=(rise/run)*(temp-325)+Viscval(4);
    Pr=(rise2/run)*(temp-325)+Prval(4);   
    k=(rise3/run)*(temp-325)+kval(4);
    
elseif 350<temp<=375
    
    rise=Viscval(6)-Viscval(5);
    rise2=Prval(6)-Prval(5);
    rise3=kval(6)-kval(5);
    
    visc=(rise/run)*(temp-350)+Viscval(5);
    Pr=(rise2/run)*(temp-350)+Prval(5);  
    k=(rise3/run)*(temp-350)+kval(5);
else
    visc=0;
end

Re=(u*L)/visc %Reynolds number

if Re<5e5 
    disp('Laminar Flow')
    Nu=.664*(Re^.5)*Pr^(1/3); %Flat Plate Correlation, laminar flow, avg [Incropera & Dewitt]
elseif Re>=5e5
    disp('Mixed Flow')
    Nu=((.037*(Re^.8))-871)*Pr^(1/3); %Flat Plate Correlation, mixed flow, avg [Incropera & Dewitt]
end

h=(Nu*k)/L %convection 
disp '   [W/m^2-K]'
heatflux=h*(ts-tfs);
disp '   [W/m^2]';
