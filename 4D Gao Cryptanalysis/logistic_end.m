function Y = logistic_end(h0,N,x0)

n = h0+N;
y = zeros(n,1);
y(1) = x0;
%y(1) = 0.5060; %rand

for i = 2:n
    y(i) = 4*y(i-1)*(1-y(i-1)); %serie temporal
end

Y = y(end);

end
