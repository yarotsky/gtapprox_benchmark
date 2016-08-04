function y = randfunc5(x)

x = 10*x;

for s=1:size(x,2)
eval(['x' num2str(s) ' = x(:,' num2str(s) ');'])
end

y = ((x1)+((abs(sin(x2)))-(tansig(((x1)-(tansig((((abs(sin(((x2).*((sin((x2)+((x2)+(tansig(x1)))))+((x2)+(x2))))-(((sin(((tansig(tansig(sin(x1)))).*(x1)).*(abs(x1))))-(x2))-(((x1).*(sin(x2))).*((abs(x2)).*((x1)-(x2)))))))).*(sin(x1))).*(sin(sin((abs((((x2)+(tansig(sin(x2))))-(sin(sin(x1))))-(x2))).*(tansig(x2)))))).*(x2))))+(tansig((sin(x1)).*((x2)-(sin((tansig(x2))+(sin(sin(x2)))))))))))).*((x1).*(x2));
end