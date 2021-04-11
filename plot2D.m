function varargout = plot2D( )

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

x = linspace(0.,1.5*w,120);
y = linspace(0.01*ybottom,0.4*ytop,120);

for i = 1:length(x)
    for j = 1:length(y)
            Z(i,j) = round(10.*T_rect_rod_x_y(x(j),y(i)))/10.;
    end
end
[X,Y] = meshgrid(x,y);
figure(1)
contourf(X,Y,Z)
title('T [K] plotted in plane z = 0')
xlabel('x [micron]')
ylabel('y [micron]')
colorbar
end