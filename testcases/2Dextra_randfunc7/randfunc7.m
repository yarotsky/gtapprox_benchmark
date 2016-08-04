function y = randfunc7(x)

x = 10*x;

for s=1:size(x,2)
eval(['x' num2str(s) ' = x(:,' num2str(s) ');'])
end

y = ((sin((abs(tansig(abs((abs(((x1)-(abs(abs(x1))))-(x2)))-(((((x1)-((x2)-(x2)))+((x1)-(sin((x2)-(((abs(x2)).*((x1).*(((tansig(sin(sin((((x2)+(x1))-(abs(x2))).*(x2)))))+((x1)+(sin(x1))))+(abs((x2)-(x1))))))+(sin(x2)))))))-(sin(sin(x2))))+(sin(x1))))))).*((sin(x2))+(x1))))-((abs(sin(x2)))+(tansig(sin((tansig(tansig(x2)))-((abs(abs(((x1)-((x2).*(x1)))+(abs(sin(x1))))))-(x1)))))))+(x2);
end