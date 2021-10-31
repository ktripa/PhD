function b = Theil_Sen_Regress(x,y)
[N c]=size(x);
Comb = combnk(1:N,2);
deltay=diff(y(Comb),1,2);
deltax=diff(x(Comb),1,2);
theil=diff(y(Comb),1,2)./diff(x(Comb),1,2);
b=median(theil);
end