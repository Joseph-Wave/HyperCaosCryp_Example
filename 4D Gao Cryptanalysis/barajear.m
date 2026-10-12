function r = barajear(cou, x0, N)

%cou = 10; % condicion inicial 1
%x0 = rand; % condicion inicial 2

r = [1:N];
r1 = r(1:N/2);
r2 = r(N/2+1:N);

c = 1;
while (c <= cou)
    i = 1; c1 = 1; c2 = 1;
    while (1)
        x0 = logistic_end(0,N,x0);
        R = mod(fix(x0*10e14),N);
        if(R > N*6/8)
           r(i) = r1(c1); r(i+1) = r1(c1+1);
           r(i+2) = r2(c2);
           i = i + 3; c1 = c1 + 2; c2 = c2 + 1;
        elseif(R > N*4/8 & R < N*6/8)
           r(i) = r2(c2); r(i+1) = r2(c2+1);
           r(i+2) = r1(c1);
           i = i + 3; c2 = c2 + 2; c1 = c1 + 1;
        else
           r(i) = r1(c1); r(i+1) = r2(c2);
           i = i + 2; c1 = c1 + 1; c2 = c2 + 1;
        end

        if(c1 + 2 > N/2 | c2 + 2 > N/2)
           while(c2 <= N/2)
              r(i) = r2(c2); i = i + 1; c2 = c2 + 1;
           end
           while(c1 <= N/2)
              r(i) = r1(c1); i = i + 1; c1 = c1 + 1;
           end
           break;
        end
    end
    r1 = r(1:N/2); r2 = r(N/2+1:N);
    c = c+1;
end

end
