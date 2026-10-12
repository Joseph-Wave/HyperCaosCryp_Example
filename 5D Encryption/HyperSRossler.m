function [X, Y, Z, W, V] = HyperSRossler(ni,M,N) %(k,L,h)

n = M*N + ni;
h = 0.0001;

x = zeros(n, 1);
y = zeros(n, 1);
z = zeros(n, 1);
w = zeros(n, 1);
v = zeros(n, 1);

a = 30;
b = 10;
c = 15.7;
d = 5;
e = 2.5;
f = 4.45;
g = 38.5;

% Condicionones iniciales
%asd = 1000; rand-randi(100)/asd;
 x(1) = 0.2305;
 y(1) = 0.6123;
 z(1) = 0.6311;
 w(1) = 0.1651;
 v(1) = 0.9811;

CI = [x(1) y(1) z(1) w(1) v(1)];


for i = 1: n-1

    k1x = a*(y(i)-x(i))+y(i)*z(i)*w(i);
    k1y = b*(x(i)+y(i)) + v(i) - x(i)*z(i)*w(i);
    k1z = -c*y(i)-d*z(i)-e*w(i)+x(i)*y(i)*w(i);
    k1w = -f*w(i)+x(i)*y(i)*z(i);
    k1v = -g*(x(i)+y(i));
   

    mx = x(i) + 0.5 * h * k1x;
    my = y(i) + 0.5 * h * k1y;
    mz = z(i) + 0.5 * h * k1z;
    mw = w(i) + 0.5 * h * k1w;
    mv = v(i) + 0.5 * h * k1v;

    %______________________________________ 
    
    k2x = a*(my-mx)+my*mz*mw;
    k2y = b*(mx+my) + mv - mx*mz*mw;
    k2z = -c*my-d*mz-e*mw+mx*my*mw;
    k2w = -f*mw+mx*my*mz;
    k2v = -g*(mx+my);

    mx = x(i) + 0.5 * h * k2x;
    my = y(i) + 0.5 * h * k2y;
    mz = z(i) + 0.5 * h * k2z;
    mw = w(i) + 0.5 * h * k2w;
    mv = v(i) + 0.5 * h * k2w;

    %______________________________________
    
    k3x = a*(my-mx)+my*mz*mw;
    k3y = b*(mx+my) + mv - mx*mz*mw;
    k3z = -c*my-d*mz-e*mw+mx*my*mw;
    k3w = -f*mw+mx*my*mz;
    k3v = -g*(mx+my);

    mx = x(i) + 0.5 * h * k3x;
    my = y(i) + 0.5 * h * k3y;
    mz = z(i) + 0.5 * h * k3z;
    mw = w(i) + 0.5 * h * k3w;
    mv = v(i) + 0.5 * h * k3v;

    %______________________________________ 

    k4x = a*(my-mx)+my*mz*mw;
    k4y = b*(mx+my) + mv - mx*mz*mw;
    k4z = -c*my-d*mz-e*mw+mx*my*mw;
    k4w = -f*mw+mx*my*mz;
    k4v = -g*(mx+my);
    
    x(i + 1) = x(i) + h*(k1x + 2*k2x + 2*k3x + k4x)/6 ;
    y(i + 1) = y(i) + h*(k1y + 2*k2y + 2*k3y + k4y)/6 ;
    z(i + 1) = z(i) + h*(k1z + 2*k2z + 2*k3z + k4z)/6 ;
    w(i + 1) = w(i) + h*(k1w + 2*k2w + 2*k3w + k4w)/6 ;
    v(i + 1) = v(i) + h*(k1v + 2*k2v + 2*k3v + k4v)/6 ;
 
end

X = x(ni+1:n);
Y = y(ni+1:n);
Z = z(ni+1:n);
W = w(ni+1:n);
V = v(ni+1:n);

%plot3(X(1:end),Y(1:end),Z(1:end), 'r.','markersize',2)
%rotate3d;

%figure
%plot(X(1:end),Z(1:end))

 
end
