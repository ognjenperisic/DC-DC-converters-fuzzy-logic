function slika(y,izlaz,niz_g,niz_p_g)
numb=1:1:length(y);
subplot(2, 1, 1);

%tezi(numb)=5;
%plot(numb,tezi);
plot(numb,y);
ylabel('Voltage')
xlabel('miliseconds')
set(gca,'xtickmode', 'manual')
set(gca,'xtick',[0:5000:length(y)])
set(gca,'xticklabel', 0:0.5:round((length(y)/1e4)))


subplot(2, 1, 2);
x=1:1:length(izlaz);
plot(x,izlaz);
ylabel('Faktor ispune')
xlabel('miliseconds')
set(gca,'xtickmode', 'manual')
set(gca,'xtick',[0:5000:length(y)])
set(gca,'xticklabel', 0:0.5:round(length(y)/1e4))
