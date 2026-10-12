
m = imread('peppers.bmp');

x = rgb2gray(m); 
[M, N] = size(x);

vi = barajear(10,rand,N);
xf = x(vi,:);

for a = 1:M
    ca = barajear(5,rand,N);
    P(a,:) = xf(a,ca);
end

[X, Y, Z, W, V] = HyperSRossler(1000,M,N);

X = mod(floor((abs(X)-floor(abs(X))).*10e14),256);
Y = mod(floor((abs(Y)-floor(abs(Y))).*10e14),256);
Z = mod(floor((abs(Z)-floor(abs(Z))).*10e14),256);
W = mod(floor((abs(W)-floor(abs(W))).*10e14),256);
V = mod(floor((abs(V)-floor(abs(V))).*10e14),256);

Zm = floor(mod(Z,4));
C = zeros(M*N,1);

for i = 1:(M*N-3)/3+1
   switch Zm(i)
       case 0 %XWV
           C(3*(i-1)+1) = bitxor(P(3*(i-1)+1),X(3*(i-1)+1));
           C(3*(i-1)+2) = bitxor(P(3*(i-1)+2),W(3*(i-1)+2));
           C(3*(i-1)+3) = bitxor(P(3*(i-1)+3),V(3*(i-1)+3));
       case 1 %YWV
           C(3*(i-1)+1) = bitxor(P(3*(i-1)+1),Y(3*(i-1)+1));
           C(3*(i-1)+2) = bitxor(P(3*(i-1)+2),W(3*(i-1)+2));
           C(3*(i-1)+3) = bitxor(P(3*(i-1)+3),V(3*(i-1)+3));
       case 2 %ZWV
           C(3*(i-1)+1) = bitxor(P(3*(i-1)+1),Z(3*(i-1)+1));
           C(3*(i-1)+2) = bitxor(P(3*(i-1)+2),W(3*(i-1)+2));
           C(3*(i-1)+3) = bitxor(P(3*(i-1)+3),V(3*(i-1)+3));
       otherwise % YZW
           C(3*(i-1)+1) = bitxor(P(3*(i-1)+1),Y(3*(i-1)+1));
           C(3*(i-1)+2) = bitxor(P(3*(i-1)+2),Z(3*(i-1)+2));
           C(3*(i-1)+3) = bitxor(P(3*(i-1)+3),W(3*(i-1)+3));    
   end
end

C = reshape(C,M,N);

subplot(2,3,1)
imshow(x)

subplot(2,3,4)
imhist(uint8(x))

subplot(2,3,2)
imshow(uint8(P))

subplot(2,3,5)
imhist(uint8(P))

subplot(2,3,3)
imshow(uint8(C))

subplot(2,3,6)
imhist(uint8(C))
