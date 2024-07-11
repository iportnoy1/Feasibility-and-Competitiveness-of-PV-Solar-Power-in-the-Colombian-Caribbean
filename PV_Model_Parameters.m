ki=0.002; q=1.6e-19; K=1.3805e-23; n=1.2;
Eg0=1.1; Rs=0.0001;%Rs=0.221; 
Rsh=1000; Tn=298.15;
Isc=6.11; Ns=36; Np=1; Voc=21.6; 
T2M = 30; Irr = 900;

figure(1); 
plot(Volt(:,2),PV(:,2)); xlabel('Voltage (V)'); ylabel('Power (W)');
figure(2); 
plot(Volt(:,2),IV(:,2)); xlabel('Voltage (V)'); ylabel('Current (A)');