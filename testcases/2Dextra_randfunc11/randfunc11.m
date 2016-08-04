function y = randfunc11(x)

x = 10*x;

for s=1:size(x,2)
eval(['x' num2str(s) ' = x(:,' num2str(s) ');'])
end

y = (sin(tansig((4)+(1))))-((abs((((x2)-((2).*(abs(2))))-(tansig(2)))+((x2)-(5))))-(((abs(sin((tansig((1)+((10)+(abs(x2)))))+((((abs(sin((12)+(sin(5)))))+((x1)+(x2))).*(1))+((abs(4))-(abs(sin(abs(sin(abs(((2)+((2)+(sin((tansig(abs(tansig((abs(5))-(13))))).*(tansig(sin((1).*(abs(((x2).*(4))+((sin(abs(x1))).*((4)-(sin(x1)))))))))))))+(5)))))))))))).*(sin((x2)+(2)))).*(x2)));
end