function [ ] = datain( )

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

hbar = 1.0545718e-34; % Planck's constant [Js]
c = 3.0e8; %light velocity[m/s]
elcharge = 1.60217662e-19; %elementary charge

wavelength = 945.0e-9; % wavelength [m]  
D = 9.6e-4; %diffusivity [m^2/s] 
tau = 4.2e-9; %carrier lifetime [s] 
A = 2.0e-12; %gain coefficient [m^3/s]
gamma = 0.0065; %confinement factor 
currentth = 0.4; %threshold current 
R = 0.1; %front facet reflectivity
z0 = 7.0e-9; %active layer thickness [m] 
vg = 1.0e8; %[m/s] group velocity 
v0 = 4000.0; % [m/s] surface recombination velocity

maxnooflayers = 60; %maximum number of layers
d = zeros([1 maxnooflayers]);
lambda = zeros([1 maxnooflayers]);

% ********geometry and parameters***************
 
% Example structure of GaAs/AlGaAs/GaAsP laser chip (without heat sink) is entered.
% If you need to have a look at the geometry, please see my works [1] or [2].
% Please do NOT insert layers of zero thickness, since it can result in an
% error while calculating K's and M's in further part of the code

 alpha = 0.; % convection cooling [W/K/micron^2], top boundary condition
    
% describe the rod layer by layer from the top to the bottom
    
 d(14)=100.0e0; % top layer thicknes [micron], GaAs substrate
 lambda(14)=55.0e-6; % top layer thermal conductivity [W/(micron*K)]
      
 d(12)=0.5e0; %GaAs buffer  
 lambda(12)=55.0e-6;  
    
 d(10)=3.5e0; %AlGaAs n-cladding (x=0.35)
 lambda(10)=11.18e-6;
    
 d(8)=0.05e0;  %AlGaAs gradient (x=0.5 -> 0.35 uœrednione)
 lambda(8)=9.69e-6;
    
 d(6)=0.05e0; %AlGaAs barrier (x=0.3)
 lambda(6)=11.0e-6;
    
 d(4)=0.18e0; %AlGaAs waveguide (x=0.3)
 lambda(4)=13.72e-6; 
    
 d(2)=0.005e0; % thicknes [micron] of the layer just above the heat source, GaAs spacer
 lambda(2)=55.0e-6; %thermal conductivity [W/(micron*K)] of the layer just above the heat source

 %******** heat source (laser active layer) **************
 w = 20.0e0; %width [micron] of the  infinitely thin stripe placed in plane y=0 
 L=3000.0e0; %resonator length [micron] of the  infinitely thin stripe placed in plane y=0 
 current = 2.0;
 voltage = 2.0;
 Pout = 1.68;     
J = (voltage*current - Pout)/(w*L); %power density [W/micron^2]
 % ******************************************************************

 d(1)=0.005e0; % thicknes [micron] of the layer just under the heat source, GaAs spacer
 lambda(1)=55.0e-6; %thermal conductivity [W/(micron*K)] of the layer just under the heat source
    
 d(3)=0.18e0; %AlGaAs waveguide (x=0.3)
 lambda(3)=13.72e-6;
    
 d(5)=0.05e0; %AlGaAs barrier (x=0.3)
 lambda(5)=11.0e-6;
    
 d(7)=0.05e0; %AlGaAs gradient (x=0.5 -> 0.35 uœrednione)
 lambda(7)=9.69e-6;
    
 d(9)=3.5e0; %AlGaAs p-cladding (x=0.35)
 lambda(9)=11.18e-6;
      
 d(11)=0.3e0; %GaAs contact layer 
 lambda(11)=55.0e-6;
      
 d(13)=2000.0e0; % bottom layer thicknes [micron]
 lambda(13)=384.00e-6; % bottom layer thermal conductivity [W/(micron*K)]
    
 b=5000.0e0; %width [microns] of the rectangular rod (laser structure)
 dsur = 1.0e0; %gruboœæ warstwy grzej¹cej przy zwierciadle [micron]
 factor = 2.0*dsur/L; %this value provides g_a = g_m (i.e. uniform heating along the resonator)
 
 % ********END of geometry and parameters***************
 
 % K - number of layers above the heat source (placed in plane y=0)
 % M - number of layers under the heat source (placed in plane y=0)
 K = 0;
 M = 0;
 for n = 1:1:maxnooflayers/2
     if (gt(d(2*n),0.001))
         K =K+1; end
     if (gt(d(2*n-1),0.001))
         M =M+1; end
 end
  
 yinterface = zeros(max(2*K+2,2*M+1));
 %  calculation of y's pointing the interfaces between layers above the
 %  heat source (y=0)
 for n = 2:2:2*K
     yinterface(n,n+2)=0.0d0;
     for i=2:2:n
            yinterface (n,n+2)  = yinterface(n,n+2)+d(i);
     end
 end
 
 %  calculation of y's pointing the interfaces between layers under y=0 (heat source)
    for n = 1:2:2*M+1
        yinterface(n,n+2)=0.0d0;
        for i=1:2:n
            yinterface (n,n+2)  = yinterface(n,n+2)-d(i);
        end
    end
    
    ytop=yinterface(2*K,2*K+2);
    ybottom=yinterface(2*M-1,2*M+1);

end

