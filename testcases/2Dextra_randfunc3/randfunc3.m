function y = randfunc3(x)

x = 10*x;

for s=1:size(x,2)
eval(['x' num2str(s) ' = x(:,' num2str(s) ');'])
end

y = (tansig(x1))-(((tansig(abs(tansig((x2).*(sin(sin(((((x1)+(x1))+(sin(x1)))+(((((sin(abs(x1))).*(sin(tansig(tansig(x1)))))-(x2)).*(x1)).*(sin(tansig((x2)-(x2))))))-(((x1)+(x2)).*((x2)-(tansig(((((tansig(sin((tansig(x2))-(x2))))-(abs(abs((abs(((x2).*((abs(abs(x1))).*(abs(x1))))+(abs(abs(x2))))).*(tansig((x1)+(x1))))))).*(x2)).*(((sin((x1)-(x2))).*(x1))+((abs(x2)).*(x1))))-(sin(x2)))))))))))))-(x2))+(x1));
end