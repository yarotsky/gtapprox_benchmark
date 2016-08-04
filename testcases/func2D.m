function y = func2D(x, funcname)
switch funcname
    case 'f1'
        t = (sum(x.^2,2)-0.3);
        y = t.^2./(t.^2+0.01);
    case 'f2'
        center1 = 0.5+zeros(length(x),2);
        center2 = zeros(length(x),2);
        y = tanh(0.3*(5*exp(-4*sum((x-0.5*center1).^2,2))-7*exp(-40*sum((x-center2).^2,2))-3*exp(-10*sum((x(:,1)+0.7).^2,2))+sum(x,2)));
    case 'f3'
        t = sum((x+0.6).^2,2)-0.3;
        y = sin(t).^2./tanh(t.^2+0.4);
    case 'f4'
        y = sum(x,2)./(1+4*sum(x.^2,2));
    case 'f5'
        center1 = 0.5+zeros(length(x),2);
        gamma = ones(length(x),2);
        y = sum(gamma.*x,2)+1*(sum((x-0*center1).^2,2)<=0.5^2)-2*(sum((x-0.7).^2,2)<=1^2);        
    case 'f1mod'
        x = 2*x-1;
        t = (sum(x.^2,2)-0.3);
        y = t.^2./(t.^2+0.01);
    case 'f2mod'
        x = 2*x-1;
        center1 = 0.5+zeros(length(x),2);
        center2 = zeros(length(x),2);
        y = tanh(0.3*(5*exp(-4*sum((x-0.5*center1).^2,2))-7*exp(-40*sum((x-center2).^2,2))-3*exp(-10*sum((x(:,1)+0.7).^2,2))+sum(x,2)));
    case 'f3mod'
        x = 2*x-1;
        t = sum((x+0.6).^2,2)-0.3;
        y = sin(t).^2./tanh(t.^2+0.4);
    case 'f4mod'
        x = 2*x-1;
        y = sum(x,2)./(1+4*sum(x.^2,2));
    case 'f5mod'
        x = 2*x-1;
        center1 = 0.5+zeros(length(x),2);
        gamma = ones(length(x),2);
        y = sum(gamma.*x,2)+1*(sum((x-0*center1).^2,2)<=0.5^2)-2*(sum((x-0.7).^2,2)<=1^2);
    case {'branin', 'Branin'}
        % rescale to -5<x1<10, 0<x2<15
        x1 = 15*x(:,1)-5;
        x2 = 15*x(:,2);
        y = (x2-5.1/4/pi^2*x1.^2+5/pi*x1-6).^2+10*(1-1/8/pi)*cos(x1)+10;
    case {'mystery', 'Mystery'}
        % rescale to 0<x1<5, 0<x2<5
        x1 = 5*x(:,1);
        x2 = 5*x(:,2);
        y = 2+0.01*(x2-x1.^2).^2+(1-x1).^2+2*(2-x2).^2+7*sin(0.5*x1).*sin(0.7*x1.*x2);
    case {'michalewicz', 'Michalewicz'}
        % rescale to 0<x1<pi, 0<x2<pi
        x1 = pi*x(:,1);
        x2 = pi*x(:,2);
        y = sin(x1).*sin(x1.^2/pi)+sin(x2).*sin(2*x2.^2/pi);
    case {'sqmichalewicz', 'Sqmichalewicz'}
        % rescale to 0<x1<pi, 0<x2<pi
        x1 = pi*x(:,1);
        x2 = pi*x(:,2);
        y = (sin(x1).*sin(x1.^2/pi)+sin(x2).*sin(2*x2.^2/pi)).^2;
    case {'rosenbrock', 'Rosenbrock'}
        % rescale to -2.048<x<2.048
        c = 2.048;
        x1 = c*(2*x(:,1)-1);
        x2 = c*(2*x(:,2)-1);
        y = 100*(x2-x1.^2).^2+(1-x1).^2;
    case {'ellipsoidal', 'Ellipsoidal'}
        % rescale to -1<x<1
        x1 = 2*x(:,1)-1;
        x2 = 2*x(:,2)-1;
        y = x1.^2+2*x2.^2;
    case {'rastrigin', 'Rastrigin'}
        % rescale to -5.12<x<5.12
        c = 5.12;
        x1 = c*(2*x(:,1)-1);
        x2 = c*(2*x(:,2)-1);
        y = 20+(x1-10*cos(2*pi*x1))+(x2-10*cos(2*pi*x2));
    case {'schwefel', 'Schwefel'}
         % rescale to -500<x<500
        c = 500;
        x1 = c*(2*x(:,1)-1);
        x2 = c*(2*x(:,2)-1);
        y = x1.*sin(sqrt(abs(x1)))-x2.*sin(sqrt(abs(x2)));
    case {'himmelblau', 'Himmelblau'}
        % rescale to -6<x<6
        c = 6;
        x1 = c*(2*x(:,1)-1);
        x2 = c*(2*x(:,2)-1);
        y = (x1.^2 + x2 -11).^2 + (x1 + x2.^2 - 7).^2;
    case {'six_hump_camel_back', 'SixHumpCamelBack'}
        % rescale to -3<x1<3, -2<x2<2
        x1 = 3*(2*x(:,1)-1);
        x2 = 2*(2*x(:,2)-1);
        a = 4.0;
        b = 2.1;
        c = 3.0;
        y = (a-b*(x1.^2)+(x1.^4)/c).*(x1.^2) + x1.*x2 + a*((x2.^2)-1).*(x2.^2);
    case {'GoldsteinPrice', 'Goldsteinprice'}
        % rescale to -2<x<2
        c = 2;
        x1 = c*(2*x(:,1)-1);
        x2 = c*(2*x(:,2)-1);
        y = ((1+(x1+x2+1).^2.*(19-14*x1 + 3*x1.^2-14*x2 + 6*x1.*x2+3*x2.^2)).*(30+(2*x1-3*x2 ).^2.*(18-32.*x1+12*x1.^2 + 48*x2-36*x1.*x2+27.*x2.^2)));
    case 'Kink'
        y = min([x(:,1).^2+x(:,2).^2, 2*x(:,1).^2], [], 2);
    case {'CurvedKink', 'Curvedkink'}
        y = min([x(:,1).^2+x(:,2).^2, 0.3*ones(size(x,1),1)], [], 2);
    case {'StraightDiscont', 'Straightdiscont'}
        y = heaviside(x(:,1)-x(:,2)-0.0000001);
    case {'RoundDiscont', 'Rounddiscont'}
        y = heaviside(1/7-(x(:,1)-1/2).^2-(x(:,2)-1/2).^2);
    case {'TwoHumps', 'Twohumps'}
        y = exp(-10*((x(:,1)-1/4).^2+(x(:,2)-1/4).^2))+2*exp(-20*((x(:,1)-3/4).^2+(x(:,2)-1/2).^2));
    case {'aero1', 'Aero1'}
        x1 = x(:,1);
        x2 = x(:,2);
        y = atan(x1.^(1/2)).*(-atan(50*(x2+0.2).^4.*(x1-0.3-0.2*x2))+2*x1.*(1-x1)+(1+x2).*x2);
    case {'aero2', 'Aero2'}
        x1 = x(:,1);
        x2 = x(:,2);
        y = (atan(x1.^(1/2)).*(-atan(80*(x2+0.2).^3.*(x1-0.3-0.3*x2))+2*x1.*(1-x1)+(1+x2).*x2)).*(1+0.2*sin(5*pi*(1-x1).*x2)+0.2*sin(x1)).*(1+0.5*atan(4*(x2-0.5))-x2);
    case {'aero3', 'Aero3'}    
        x1 = x(:,1);
        x2 = x(:,2);    
        x1 = x1.*(1+0.3*sin(pi*(1-x1).*x2));
        x2 = x2.*(1+0.15*sin(pi*x1.*(1-x2)));
        phi = 0.003*pi*(0.1+(x1-0.7).^2+(x2-0.6).^2).^(-2);
        x1 = 0.7+(x1-0.7).*cos(phi)-(x2-0.6).*sin(phi);
        x2 = 0.6+(x1-0.7).*sin(phi)+(x2-0.6).*cos(phi);
        y = (1+0.2*sin(2*pi*x1.*x2)).*(x1+0.2*sin(-pi*x2.^6)+0.4*x1.*(1-x2).*((cos(x1.^2+x2.^2-1)).^100)+0.3*exp(-30*(abs(x1-0.6)).^1.9-150*(x2-0.7).^2)+0.2*exp(-50*(x1-0.3).^2-200*(abs(x2-0.8)).^2.4)+0.3*exp(-500*(x1-0.9).^2-400*(x2-0.75).^2)...
            +0.13*exp(-700*(x1-0.85).^2-500*(x2-0.65).^2));
    case 'linear'
        x1 = x(:,1);
        x2 = x(:,2);
        y = x1+x2;
    case 'gauss'
        y = exp(-4*sum(x.^2,2));
    case 'randfunc'
        y = randfunc(x);
end
end