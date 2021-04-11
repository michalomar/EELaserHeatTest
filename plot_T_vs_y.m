function varargout = plot_T_vs_y( )

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

figure(3)
n_of_points = 2000;
yleft = ybottom; yright = ytop; yspace = (yright - yleft)/n_of_points;
yaxis = yleft:yspace:yright;
for i = 1:length(yaxis)
    T_vs_y(i) = T_rect_rod_x_y(0.,yaxis(i));
end

plot(yaxis,T_vs_y, 'LineWidth', 2)
left_end = yleft;
right_end = yright;
xlim([left_end right_end])
title('Transverse temperature profile')
xlabel('y [micron]')
ylabel('T [K]')

fid = fopen('T_vs_y.dat','a');
pom = [yaxis;T_vs_y];
fprintf(fid,'%12.6f %12.6f \n',pom);
fclose(fid);
end

