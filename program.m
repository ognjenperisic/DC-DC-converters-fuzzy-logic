
broj=50000;                   % broj iteracija
odbir=0.0000001;              % vreme odabiranja (sampling time)
broj*odbir
faktor=400;                   % pocetni faktor ispune (u hiljaditim delovima)
n=2                           % koeficijent promene faktora ispune
kg=1;
kpg=200;

proba=readfis('DC_SUGENO');   % ucitavanje parametara fuzzy sistema


          % model kola iz knjige Prof. Petrovica
r=0.5;                         % opterecenje
rc=0.0465;                     % otpornost kondenzatora
rl=0.0235;                     % otpornost kalema
l=50e-6;                       % induktivnost kalema
c=4700e-6;                     % kapacitivnost kondenzatora

                  % Uzeo sam da je Ig=0 A, a Vin je 10v 
u=[10;0];                      % ulazni napon i struja opterecenja         
referenca=5;                   % referentni ulaz 
A=[-(r*rl+r*rc+rl*rc)/((r+rc)*l)-r/((r+rc)*l);
 r/((rc+r)*c) -1/((r+rc)*c)]; 
E1=[1/l    -r*rc/((r+rc)*l); 0    r/((r+rc)*c)];
E2=[0  -r*rc/((r+rc)*l); 0    r/((r+rc)*c)];
C=[rc*r/(rc+r) r/(r+rc)];
D=[0 r*rc/(r+rc)];
sys1=ss(A,E1,C,D);             % kontinualni oblik modela kada je ukljucen S1
dsys1=c2d(sys1,odbir,'zoh');   % diskretni oblik modela kada je ukljucen S1
sys2=ss(A,E2,C,D);             % kontinualni modela kada je ukljucen S2
dsys2=c2d(sys2,odbir,'zoh');   % diskretni oblik modela kada je ukljucen S2

x=[0;0];                       % pocetne vrednosti 
y=0;
greska=0;
pr_greska=0;
pgreska=0;
sr=0;
s=0;
izlaz=0;
pomoc=0;
greska=0;
pr_greska=0;
niz_g=0;
niz_p_g=0;
dk=0;

for i=1:broj                    % pocetak petlje
     xold=x;

     if rem(i,1000)==0
        pomoc=i 
     end          
     
     greska_old=pgreska;    % promenljiva koja moze, ali i ne mora da se uvrsti u 
                            % program zato sto malo utice na brzinu promene izlazne 	      		             % promenljive  	
     faktor_old=faktor;  
     
     if abs(i-pomoc)<faktor
          x=dsys1.a*xold+dsys1.b*u;     % ukljucen prekidac  S1
          y(i)=dsys1.c*xold+dsys1.d*u;
          %disp('Prvo!')
     else
          x=dsys2.a*xold+dsys2.b*u;     % iskljucen prekidac  S1
          y(i)=dsys2.c*xold+dsys2.d*u;
          %disp('Drugo')
     end
     
     greska=kg*(y(i)-referenca);
     pgreska=greska;
     pr_greska=kpg*(greska-greska_old);
         
     if abs(greska)>1 
        greska=sign(greska);
     end
     
     if abs(pr_greska)>1 
        pr_greska=sign(pr_greska);
     end

     if rem(i,200)==0
        dk=evalfis([greska,pr_greska],proba);   % izlaz sklopa za zakljucivanje
        faktor=faktor_old + dk*(n+abs(dk));     % nova vrednost faktora ispune
     end  
   
     if (rem(i,10000)==0) 
        slika(y,izlaz,niz_g,niz_p_g)            % procedura za prikazivanje rezultata
        pause 
     end  
 
     if (i<6000) 
         if (rem(i,5000)==0) 
            u=[15;0];           % promena ulaza, moze se izvesti i promena opterecenja        
            sprintf('Promena uslova\n');
         end   
     end
   
     izlaz(i)=faktor/10; 
     fuzzy_i(i)=dk;
     niz_g(i)=greska;
     niz_p_g(i)=pr_greska;
   
end                             % kraj petlje

s=0;			        % racunanje srednje vrednosti izlaznog napona	
for i=1:broj
   s=s+y(i);
end
s=s/(broj)
close all
slika(y,izlaz,niz_g,niz_p_g)   % procedura za prikazivanje rezultata
broj*odbir

