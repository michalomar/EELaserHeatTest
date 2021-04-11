function varargout = plot_T_vs_z( )

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

T_j = round(10.*T_rect_rod_z_y(0.,0.))/10.; % calculation of junction temperature
T_m = round(10.*T_rect_rod_z_y(-L/2,0.))/10.; % calculation of mirror temperature

disp ('T_j funkcja')
disp (T_j)
disp ('T_m funkcja')
disp (T_m)

figure(4)
n_of_points = 1500;
zleft = -L/2.0; zright = 0.; zspace = (zright - zleft)/n_of_points;
zaxis = zleft:zspace:zright;
T_vs_z = T_rect_rod_z_y(zaxis,0.);

plot(zaxis,T_vs_z, 'LineWidth', 2)
left_end = zleft-100.0;
right_end = zright;
xlim([left_end right_end])
title('Axial temperature profile: from the mirror to the resonator center')
xlabel('z [micron]')
ylabel('T [K]')

ztext = zleft + 0.25*(zright - zleft); Ttext = 0.9*T_m;
txt = ['Mirror temperature T_m = ' num2str(T_m) ' K'];
text(ztext,Ttext,txt,'FontSize',12)
txt = ['Junction temperature T_j = ' num2str(T_j) ' K'];
text(ztext,Ttext - 0.1*T_m,txt,'FontSize',12)

fid = fopen('T_vs_z.dat','a');
pom = [zaxis;T_vs_z];
fprintf(fid,'%12.6f %12.6f \n',pom);
fclose(fid);
%varargout{1} = 0.;
end

