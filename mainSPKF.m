% If you use this code in your publication, please cite:
% 
% Kawakita de Souza, A. (2020). Advanced Predictive Control Strategies for Lithium-Ion Battery 
% Management Using a Coupled Electro-Thermal Model [Master thesis, University of 
% Colorado, Colorado Springs]. ProQuest Dissertations Publishing.
% URL:https://mountainscholar.org/handle/10976/167269


close all ; clear all;

% load model 
load('A123CETmodel.mat');

% load lab data of cell discharging using UDDS drive cycles
load('Dataset'); % loads data
Tc0 = 40;        % Tc initial guess
Ts0 = 40;        % Ts initial guess
SOC0 = 0.9;      % SOC initial guess


% Covariance values
SigmaX0 = diag([1e-5 1e-4 .5e-2 1e-1 1e-1]); % uncertainty of initial state
SigmaV = diag([1e-1 2e-5]); % Uncertainty of voltage and surf. temp. sensor, output equation
SigmaW = diag([1e-5 1e-4 1e-4 1e-2 1e-3]); % Uncertainty of current and amb. temp. sensor, state equation


% Prepare data
init = 1;
time = Data.time(init:end); deltat = time(2)-time(1);
time = time-time(1); % start time at 0
current = -Data.current(init:end); % discharge > 0; charge < 0.
voltage = Data.voltage(init:end);
Tf = Data.Tf(init:end);
Ts = Data.Ts(init:end);


% setup storage
zk = zeros(size(current));
zkBounds = zeros(size(current));
hk = zeros(size(current));
hkBounds = zeros(size(current));
irck = zeros(size(current));
irckBounds = zeros(size(current));
Tck = zeros(size(current));
TckBounds = zeros(size(current));
Tsk = zeros(size(current));
TskBounds = zeros(size(current));


% Initialize SPKF - data structure
spkfData = initSPKF(SigmaX0,SigmaV,SigmaW,model,SOC0,Tc0,Ts0);



% Now, enter loop for remainder of time, where we update the SPKF
% once per sample interval
hwait = waitbar(0,'Computing KF Estimation...');
for k = 1:length(voltage),
v = voltage(k); % "measure"  voltage
ik = current(k); % "measure" current
Tfk = Tf(k);    % "measure" amb. temperature
Tsk = Ts(k);    % "measure" surface temperature

% Update SOC (and other model states)
[spkfData,vk(k)] = iterSPKF(v,ik,spkfData.xhat(4),Tfk,Tsk,deltat,spkfData);
% update waitbar periodically, but not too often (slow procedure)


% storing 
irck(k) = spkfData.xhat(1);
hk(k) = spkfData.xhat(2);
zk(k) = spkfData.xhat(3);
Tck(k) = spkfData.xhat(4);
Tsk(k) = spkfData.xhat(5);
irckBounds(k) = spkfData.irckBounds;
hkBounds(k) = spkfData.hkBounds;
zkBounds(k) = spkfData.zkBounds;
TckBounds(k) = spkfData.TckBounds;
TskBounds(k) = spkfData.TskBounds;

if mod(k,1000)==0, waitbar(k/length(current),hwait); end;
end
close(hwait);



% Plot soc estimate
figure();  
plot(time',100*zk); hold on
plot(time',100*(zk+zkBounds),'--r');hold on
plot(time',100*(zk-zkBounds),'--r');
title('SOC estimate');
ylabel('State of charge [%]');
legend('Estimate','Bounds'); grid on;xlim([0 time(end)])
xlabel ('Time [s]');
plotFormat;

% Plot temperature estimate
figure();
plot(time',Tck,'linewidth',1.1);hold on;
plot(time',Tck+TckBounds,'--r');hold on;
plot(time',Tck-TckBounds,'--r');grid on;
legend('Estimate','Error Bounds','location','best');
xlim([time(1),time(end)]);
title('Temp. estimate')
ylabel ('Temperature [{\circ}C]');
xlabel (['Time [s]']);
plotFormat;

% Plot voltage
figure();  
plot(time,voltage);
xlabel ('Time [s]'); ylabel('Voltage [V]'); 
xlim([0 time(end)])
plotFormat;


% Plot current
figure()
plot(time,current);xlabel ('Time [s]');
ylabel('Current [A]');grid on;
xlim([0 time(end)]);
title('Input current profile');
plotFormat;



