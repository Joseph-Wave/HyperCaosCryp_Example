function [Y, m] = logistic(h0,M,N)

u = 4;

n = h0+M*N;

y = zeros(n,1);
t = zeros(n,1);

y(1) = 0.5060; %rand

for i = 2:n
    y(i) = u*y(i-1)*(1-y(i-1));
    t(i) = t(i-1)+1; 
end
Y = y(h0+1:end);

m = zeros(M*N,1);

for i = 1:M*N
    m(i) = floor(mod(Y(i)*10^4,3))+1;    
end

%Yi = zeros(M*N,1);
%Yi = Y(2:end);
%Yi(M*N) = Y(1);

%subplot(3,1,1)
%plot(t(h0:end),y(h0:end))
%title('t VS y')

%subplot(3,1,2)
%plot(t(h0+1:end),m(1:end))
%title('t VS m')

%subplot(3,1,3)
%plot(Y(1:end),Yi(1:end),'.')
%title('y VS y+1')

end

