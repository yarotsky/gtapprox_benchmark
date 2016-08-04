function y = func1D(x, funcname)
switch funcname
    case 'f1'
        tau = 0.36;
        y=-4*sin(3*x).^2.*(x<tau)+sin((1.5-4*x)).*(x>tau)+(x>0.7);
    case 'f2'
        y=x.*(x<=0.3)+(0.6-x).*(x>0.3).*(x<=0.7)+1*(x-0.8).*(x>0.7);
    case 'f3'
        y=exp(-30*(x-0.5).^2)-2*exp(-100*(x-0.7).^2)-10*exp(-50*(x-0.3).^2);
    case 'f4'
        y=tanh(cos(0.3*x+30*x.^2));
    case 'f5'
        y=(1./(0.1+abs(x-0.5).^2));
    case 'f6'
        y=(1-4*x.^2).*(x<0.5)+2*(x-0.5).*(x>0.5);
    case 'f7' % kinky, 8 oscillations
        y=max([tanh(cos(0.3*x+50*x.^3)), -x.^3],[],2);
    case 'f8' % discont, oscillations
        y=heaviside(tanh(cos(0.3*x+100*x.^4)))+tanh(cos(0.3*x+100*x.^4));
    case 'f1mod'
        x = 2*x-1;
        tau = 0.36;
        y=-4*sin(3*x).^2.*(x<tau)+sin((1.5-4*x)).*(x>tau)+(x>0.7);
    case 'f2mod'
        x = 2*x-1;
        y=x.*(x<=0.3)+(0.6-x).*(x>0.3).*(x<=0.7)+1*(x-0.8).*(x>0.7);
    case 'f3mod'
        x = 2*x-1;
        y=exp(-30*(x-0.5).^2)-2*exp(-100*(x-0.7).^2)-10*exp(-50*(x-0.3).^2);
    case 'f4mod'
        x = 2*x-1;
        y=tanh(cos(0.3*x+30*x.^2));
    case 'f5mod'
        x = 2*x-1;
        y=(1./(0.1+abs(x-0.5).^2));
    case 'f6mod'
        x = 2*x-1;
        y=(1-4*x.^2).*(x<0.5)+2*(x-0.5).*(x>0.5);
    case 'f7mod' % kinky,  oscillations
        x = 2*x-1;
        y=max([tanh(cos(0.3*x+50*x.^3)), -x.^3],[],2);
    case 'f8mod' % discont, oscillations
        x = 2*x-1;
        y=heaviside(tanh(cos(0.3*x+100*x.^4)))+tanh(cos(0.3*x+100*x.^4));
    case {'classic', 'Classic'}
        y = (6*x-2).^2.*sin(12*x-4);
    case {'sin2pix', 'Sin2pix'}
        y = sin(2*pi*x);
    case {'sin10pix', 'Sin10pix'}
        y = sin(10*pi*x);
    case {'airfoil', 'Airfoil'}
        y = sqrt(x).*(1-x).*(1.2-x);
    case {'heaviside', 'Heaviside'}
        y = heaviside(x-0.500001);
    case {'kink', 'Kink'}
        y = exp(-4*abs(x-0.8));
    case {'pressure1', 'Pressure1'}
        y = x.^(0.3).*(1-x)-0.05*atan(30*(x-0.05))+0.15*exp(-50*(x-0.45).^2)-0.20*exp(-70*(x-0.9).^2);
    case {'pressure2', 'Pressure2'}
        x = x.*((3-x)/2+0.01*sin(pi*x));
        y = x.^(0.55).*(1-0.99*x).^0.48-0.11./(1+100*(x-0.3).^2)-0.02*exp(-200*(x-0.5).^2);
    case {'pressure3', 'Pressure3'}
        t1 = 0.33826;
        t2 = 0.82743;
        t3 = 0.92213;
        i1 = x<t1;
        i2 = x>t1 & x<t2;
        i3 = x>t2 & x<t3;
        i4 = x>t3;
        t = x(i1);
        y(i1) = 5*t-11*t.^2;
        t = x(i2);
        y(i2) = cos(4*t)+0.05*exp(4*t)+0.2*exp(-100*(t-0.5).^2)+0.15*exp(-2000*(t-0.75).^2)+0.8*t-0.3;
        t = x(i3);
        y(i3) = 0.74;
        t = x(i4);
        y(i4) = 0.74-10*(t-0.9).^2;
        y = y';
    case {'heaviside_lin', 'Heaviside_lin'}
        y = heaviside(x-0.500001)+x;
end