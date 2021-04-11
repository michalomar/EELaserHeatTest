global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

% Main quantities to be calculated:  T_j - junction temperature and T_m - mirror temperature
% In all cases we consider relative temperatures (i.e. exceeding the ambient temperature considered 
% to be zero)

datain % data input

T_j = T_rect_rod_x_y(0.,0.); % calculation of junction temperature
plot2D
plot_T_vs_x
plot_T_vs_y

b = L; % contour rotation (consequently the length length becomes the width of the structure)

% BISECTION METHOD for finding J_{eff} 
% junction temperatures calculated before (T_j) and after rotation (T_j_rot) of the contour
% must be the same, so the value of J=J_{eff} providing zero temperature
% difference (T_d) is searched
Jmax = J;
Jmin = 0.01*J;

%J = Jmax is defined in function datain
T_j_rot = T_rect_rod_z_y(0.,0.); %calculation of junction temperature after contour rotation for J=Jmax
TdJmax = T_j - T_j_rot; %Td for J=Jmax

J = Jmin;
T_j_rot = T_rect_rod_z_y(0.,0.); %calculation of junction temperature after contour rotation for J=Jmin
TdJmin = T_j - T_j_rot; %Td for J=Jmin

while abs(Jmax - Jmin) > 1e-9

Jav = (Jmin + Jmax)/2.0;
J = Jav;
T_j_rot = T_rect_rod_z_y(0.,0.); %calculation of junction temperature after contour rotation for J = Jav
TdJav = T_j - T_j_rot;

if lt(TdJmin*TdJav,0.)
         Jmax=Jav;
         J = Jmax;
         T_j_rot = T_rect_rod_z_y(0.,0.);
         TdJmax = T_j - T_j_rot;
end

if lt(TdJav*TdJmax,0.)
         Jmin=Jav;
         J = Jmin;
         T_j_rot = T_rect_rod_z_y(0.,0.);
         TdJmin = T_j - T_j_rot;
end

end
% end of BISECTION METHOD J_{eff} has been found xxxxxxxxxxxxxxxxxxxxxxxx

TotHeatMirror = (SurfRecHeat*1.0e-12) * (1.0/SurfRecShare); %total heating at mirror surface (q_res)
factor = 2.0*TotHeatMirror*dsur/(J*L); %how much of the total effective power is dissipated in the vicinity of mirrors
T_m = T_rect_rod_z_y(-L/2,0.);


%OUTPUT BLOCK
T_j = round(10.*T_j)/10.;
disp ('T_j')
disp (T_j)
T_m = round(10.*T_m)/10.;
disp('T_m')
disp(T_m)

plot_T_vs_z

fid2 = fopen('T_information.dat','a');
fprintf(fid2,'%s %6.1f \n','Mirror temperature = ',T_m);
fprintf(fid2,'%s %6.1f \n','Junction temperature = ',T_j);
fclose(fid2);