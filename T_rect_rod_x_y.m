function varargout = T_rect_rod_x_y(x,y) 

global alpha b c current currentth dsur D elcharge factor A gamma hbar J K  lambda L M Pout R tau...
    vg v0 w wavelength ybottom yinterface ytop z0

  % where is y (in which layer)? 
   if (y>=0.) 
       nocurrentl = 2;
       for n=2*K:-2:4
           if ((y>=yinterface(n-2,n)) && (y<=yinterface(n,n+2))) 
               nocurrentl=n; end
       end
   else
       nocurrentl = 1;
       for n=2*M-1:-2:3
           if ((y<=yinterface(n-2,n)) && (y>=yinterface(n,n+2))) 
               nocurrentl=n; end
       end
   end
   
%   note that the heat source function is of even parity and thus may be expanded
%   into cosine Fourier series with coefficients a0 and ak  

% Temperature of 0th order 
   
  wB(2*K)=-alpha/(lambda(2*K)+alpha*ytop);
  wA(2*K)=1.0d0;   
  for n=2*K-2:-2:2
       wB(n)=(lambda(n+2)/lambda(n))*wB(n+2);
       wA(n)=wA(n+2)+(wB(n+2)-wB(n))*yinterface(n,n+2);
 end
      
 wB(2*M-1)=-1.0d0/ybottom;
 wA(2*M-1)=1.0d0;
 for n=2*M-3:-2:1
      wB(n)=(lambda(n+2)/lambda(n))*wB(n+2);
      wA(n)=wA(n+2)+(wB(n+2)-wB(n))*yinterface(n,n+2);
 end
      
      a0=J*w/b;

%   A2K - constant (see the references for details)
      A2K=a0/(lambda(1)*wA(2)*wB(1)/wA(1)-lambda(2)*wB(2)); 
      
if (mod(nocurrentl,2) == 0) 
    T=A2K*(wA(nocurrentl)+wB(nocurrentl)*y);
else
   T=(wA(2)/wA(1))*A2K*(wA(nocurrentl)+wB(nocurrentl)*y);
end
      
%  Temperature in kth order (see the references for details)
 for k = 1:1:1600
      mu=2.0*k*pi/b;   
      wA(2*K)=1.0d0;
      wB(2*K)=((mu*lambda(2*K)+alpha)/(mu*lambda(2*K)-alpha))*exp(2.0d0*mu*ytop);
      for n=2*K-2:-2:2
           auxcon1=(lambda(n)+lambda(n+2))*wA(n+2);
           auxcon2=(lambda(n)-lambda(n+2))*wB(n+2)*exp(-2.0d0*mu*yinterface(n,n+2));
           wA(n)=(auxcon1+auxcon2)/2.0d0/lambda(n);
           wB(n)=(wA(n+2)-wA(n))*exp(2.0d0*mu*yinterface(n,n+2))+wB(n+2);
      end
      
      wB(2*M-1)=-exp(2.0d0*mu*ybottom);
      wA(2*M-1)=1.0d0;
      
      for n=2*M-3:-2:1
         auxcon1=(lambda(n)+lambda(n+2))*wA(n+2);
         auxcon2=(lambda(n)-lambda(n+2))*wB(n+2)*exp(-2.0d0*mu*yinterface(n,n+2));
         wA(n)=(auxcon1+auxcon2)/2.0d0/lambda(n);
         wB(n)=(wA(n+2)-wA(n))*exp(2.0d0*mu*yinterface(n,n+2))+wB(n+2);
      end
       
       ak=2.0*J*sin(k*pi*w/b)/k/pi;

       A2K=ak/mu/(lambda(1)*(wA(2)+wB(2))*(wA(1)-wB(1))/(wA(1)+wB(1))-lambda(2)*(wA(2)-wB(2)));

      if (mod(nocurrentl,2) == 0)
         T=T+A2K*(wA(nocurrentl)*exp(mu*y)+wB(nocurrentl)*exp(-mu*y))*cos(mu*x);
      else
          %poni¿ej celowe ograniczenie wg. Zeszyt dn. 7.04.21, aby cz³on
          %exp(-mu*y) nie "wybucha³ " do Inf dla du¿ych ujemnych y
          if (k < -705.0*b/(2.0*pi*y))  
              T=T+((wA(2)+wB(2))/(wA(1)+wB(1)))*A2K*(wA(nocurrentl)*exp(mu*y)+wB(...
              nocurrentl)*exp(-mu*y))*cos(mu*x);
          else
              T=T+((wA(2)+wB(2))/(wA(1)+wB(1)))*A2K*wA(nocurrentl)*exp(mu*y)*cos(mu*x);
          end
      end
 end
 varargout{1} = T;
end

