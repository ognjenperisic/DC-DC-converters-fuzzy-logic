function slika(y,izlaz,niz_g,niz_p_g,broj)
numb=1:1:broj;
subplot(2, 1, 1);

%tezi(numb)=5;
%plot(numb,tezi);
plot(numb,y);
ylabel('Voltage')
ylabel('Voltage')
xlabel('miliseconds')
set(gca,'xtickmode', 'manual')
set(gca,'xtick',[0:5000:length(y)])
set(gca,'xticklabel', 0:0.5:(length(y)/1e4))

subplot(2, 1, 2);
x=1:1:broj;
plot(x,izlaz);
ylabel('Izlaz')
xlabel('miliseconds')
set(gca,'xtickmode', 'manual')
set(gca,'xtick',[0:5000:length(y)])
set(gca,'xticklabel', 0:0.5:(length(y)/1e4))

