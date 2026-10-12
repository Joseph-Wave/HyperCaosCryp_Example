function ok = all_element(y, N)
%muestra 1 si estan todos los numeros

deck = zeros(1,N);
for i = 1:N 
    deck(i) = i; 
end
total = ismember(deck,y);

ok = sum(total)/N;
end