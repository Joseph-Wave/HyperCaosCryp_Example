P = imread('lenabw.bmp'); % plain image
[M,N] = size(P); % [renglones, columnas]

%M = 1024; N = 1024;

%M*N/4
[X, Y, Z, W, V] = HyperSRossler(1000,M/2,N/2);
[YS, m] = logistic(1000,M,N);

K1 = [W X Z Y]; K2 = [V W Y Z]; % K
K3 = [X Z Y V]; K4 = [Y V Z X];

[f, l] = sort(YS);

K11 = K1(l); K22 = K2(l); % K'
K33 = K3(l); K44 = K4(l);

k11 = zeros(M*N,1); k22 = k11; k33 = k11; k44 = k11;

k11 = K11.*(10.^m)-round(K11.*(10.^m)); % k'
k22 = K22.*(10.^m)-round(K22.*(10.^m));
k33 = K33.*(10.^m)-round(K33.*(10.^m));
k44 = K44.*(10.^m)-round(K44.*(10.^m));

k1 = zeros(M*N,1); k2 = k1; k3 = k1; k4 = k1;

k1 = floor(mod(abs(k11).*(10.^12),256)); % k
k2 = floor(mod(abs(k22).*(10.^12),256));
k3 = floor(mod(abs(k33).*(10.^12),256));
k4 = floor(mod(abs(k44).*(10.^12),256));

if (0) % Graficar correlaciones
    a = xcorr(X,'unbiased');
    [d f] = size(a); t = linspace(-6.*10.^(4),6.*10.^(4),d); t = t';
    subplot(2,2,1)
    plot(t,a);
    title('Auto-correlacion x1')

    [a b] = xcorr(X,Y,'unbiased');
    subplot(2,2,2)
    plot(b,a);
    title('Correlacion x1 y x2')

    a = xcorr(k11,'unbiased');
    [d f] = size(a); t = linspace(-6.*10.^(4),6.*10.^(4),d); t = t';
    subplot(2,2,3)
    plot(t,a);
    title('Auto-correlacion k´')

    [a b] = xcorr(k11,k22,'unbiased');
    subplot(2,2,4)
    plot(b,a);
    title('Correlacion k1´ y k2´')
end

kr = zeros(N,4);
kc = zeros(M,4);

t1 = 0; t2 = 0; % k = 1:1:(M+N)*2;
for j = 1:4 % rotation times
   for i = 1:N
       t1 = t1 + 1;
       kr(i,j) = k4(1+2*t1);
   end
   for i = 1:M   
       t2 = t2 + 1;
       kc(i,j) = k4(2+2*t2);
   end
end

% Aqui empiezan las 4 rondas

for r = 1:4
    Ps = zeros(M+1,N+1); % P'
    Ps(1,2:N+1) = kr(:,r); % = kr(:,r) #######
    Ps(2:M+1,1) = kc(:,r); % = kc(:,r)
    Ps(2:M+1,2:N+1) = P; % processed image

    Cs = zeros(M,N); % C' -> confused pixels
    Css = zeros(M+1,N+1); % C'' -> encrypted pixels
    k1ss = reshape(k1,M,N); % k1'' #######
    k2ss = reshape(k2,M,N); % k2''
    k3ss = reshape(k3,M,N); % k3''
    js = zeros(N,1); % j'

    Css(1,2:N+1) = Ps(1,2:N+1);
    Css(2:M+1,1) = Ps(2:M+1,1);

    i = 2;
    for j = 2:N+1
        js(j-1) = j + mod(k3ss(i-1,j-1)+Css(i,j-1),M+1-j+1); % #######
        i = i + 1;
    end
    for i = 2:M+1
        for j = 2:N+1
            Cs(i-1,j-1) = Ps(i,js(j-1));
        end
    end
    for i = 2:M+1
        for j = 2:N+1
            Ps(i,js(j-1)) = Ps(i,j);
        end
    end
    for i = 2:M+1
        for j = 2:N+1
            a = mod(k1ss(i-1,j-1)+Cs(i-1,j-1),256);
            a = bitxor(a,mod(Css(i-1,j)+Css(i,j-1),256),'uint8');
            Css(i,j) = bitxor(a,k2ss(i-1,j-1),'uint8');
        end
    end

    C = Css(2:M+1,2:N+1); % cipher image
    %imshow(uint8(C))
    
    if (r == 3)
        for i = 1:r-1
            C = rot90(C);
        end
    else
        for i = 1:r+1
            C = rot90(C);
        end
    end
end

subplot(1,2,1)
imshow(uint8(P))
title('Plain image')

subplot(1,2,2)
imshow(uint8(C))
title('Cipher image')

clearvars -except P C
