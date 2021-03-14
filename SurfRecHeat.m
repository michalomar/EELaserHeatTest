function varargout = SurfRecHeat( )

% SurfRecHeat: Heat power density [Watt over m^2 ] generated in the
% vicinity of mirror of the edge-emitting laser. The heat (versus pumping current [A]) is generated due
% to surface recombination.

%   The heat is generated at the surface of rectangle - slice of active layer (in this case infinitely thin) reaching the distance of carrier
%        diffusion length deep into resonator, as described in [2], result in [W/m^2]


%  [2]  M. Szymañski, A. Kozlowska, A. Mal¹g, P. Hoser, Two-dimensional model of heat flow in edge-emitting 
%        laser revisited: a new and more versatile approach, (2020), Int. J. Numer. Model. El., 
%        DOI: 10.1002/jnm.2745.

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

omega = 2.0*pi*(c/wavelength); % [1/s]
Pt = (1.0+R)*gamma*Pout/((w*1.0e-6)*z0*(1.0-R)*hbar*omega*vg); % [1/m^3] photon density, equation (22) from [1] 
Nth = (tau*currentth)/(z0*elcharge*(w*1.0e-6)*(L*1.0e-6)); %threshold carrier density [1/m^3]
if current >= currentth
    m = sqrt(((1/tau) + A*Pt)/D);
    q =hbar*omega*v0*Nth*(m/(m+(v0/D))); % [W/m^2] power density  above threshold, equation (25) from [1]
else 
    warning('Current below the threshold.')
end

powerden = q*(z0/(dsur*1.0e-6)); % [W/m^2] as described in [2]
 
varargout{1} = powerden;


