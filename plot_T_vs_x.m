function varargout = plot_T_vs_x( )

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

figure(2)
n_of_points = 1500;
xleft = 0.; xright = 150.0; xspace = (xright - xleft)/n_of_points;
xaxis = xleft:xspace:xright;
T_vs_x = T_rect_rod_x_y(xaxis,0.);

plot(xaxis,T_vs_x, 'LineWidth', 2)
left_end = xleft;
right_end = xright;
xlim([left_end right_end])
title('Lateral temperature profile')
xlabel('x [micron]')
ylabel('T [K]')

fid = fopen('T_vs_x.dat','a');
pom = [xaxis;T_vs_x];
fprintf(fid,'%12.6f %12.6f \n',pom);
fclose(fid);
end

