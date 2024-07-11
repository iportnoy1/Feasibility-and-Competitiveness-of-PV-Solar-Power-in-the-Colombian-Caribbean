%% Cleaning
clear; clc; close all

%% Loading Temperature (at 2m) and Irradiance Data
X = readtable('Hourly_Radiation_Barranquilla_Typical_Year.csv');
%Extracting variable names
varnames=X.Properties.VariableNames;

%% Plotting hourly average (+-2*sd) temp. and irr. for a typical (2023) day
X_Collapsed = varfun(@mean,X,'GroupingVariables',{'HR'});
var_X = varfun(@var,X,'GroupingVariables',{'HR'});
sd_T = (var_X.var_T2M).^0.5; 
x = 1:24;
Tu = (X_Collapsed.mean_T2M + 2*sd_T)';
Tl = (X_Collapsed.mean_T2M - 2*sd_T)';
x2 = [x, fliplr(x)];
inBetween = [Tu, fliplr(Tl)];
grayColor = [.9 .9 .9];
figure(1); xlabel('Hour'); ylabel('T2M (Celsius)'); hold on
fill(x2, inBetween, grayColor); hold on;
plot(x, X_Collapsed.mean_T2M, 'b-', 'LineWidth', 1.1);
sd_Irr = (var_X.var_ALLSKY_SFC_SW_DWN).^0.5;
Irru = (X_Collapsed.mean_ALLSKY_SFC_SW_DWN + 2*sd_Irr)';
Irrl = (X_Collapsed.mean_ALLSKY_SFC_SW_DWN - 2*sd_Irr)';
inBetween2 = [Irru, fliplr(Irrl)];
figure(2); xlabel('Hour'); ylabel('Irrandiance (W/m2)'); hold on
fill(x2, inBetween2, grayColor); hold on;
plot(x, X_Collapsed.mean_ALLSKY_SFC_SW_DWN, 'r-', 'LineWidth', 1.1);

%% Defining the PV Model Parameters
ki=0.002; q=1.6e-19; K=1.3805e-23; n=1.2; Eg0=1.1; Rs=0.0001; Rsh=1000; 
Tn=298.15; Isc=6.11; Ns=36; Np=1; Voc=21.6;

%% Pre-locating the outcomes matrix
Outcomes = zeros(length(table2array(X(:,1))),3);

% %% Running the simulation for a whole year (2023)
% for i=1:length(table2array(X(:,1)))
% T2M = X.T2M(i); Irr = X.ALLSKY_SFC_SW_DWN(i);
% Outcomes(i,1) = T2M; Outcomes(i,2) = Irr;
% sim('PV_Model3');
% Outcomes(i,3) = Power(1,2);
% end
% 
% %% Converting Outcomes matrix into table and assigning varnames
% Outcomes=array2table(Outcomes,'VariableNames',{'T' 'Irradiance' 'Power'});
% 
% %% Saving Outcomes into an Excel Sheet
% Outcomes2 = table2array(Outcomes);
% xlswrite('Outcomes.xlsx', Outcomes2);
