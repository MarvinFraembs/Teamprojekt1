clc;
clear all;
close all;

p.k1 = 0.007;                   % 1/s
p.k2 = 0.007;                   % 1/s
p.k3 = 0.0012;                  % 1/s
p.V = 0.1;                      % m^3
p.cA_in = 1000;                 % mol/m^3
%p.F_in = [10000/3600, 1000/3600, 100/3600, 10/3600];
p.F1_in = 10000/(3600*1000);    % m^3/s
% p.F2_in = 1000/3600; 
% p.F3_in = 100/3600;
% p.F4_in = 10/3600;

%%Solverparameter 
y0 = [p.cA_in 0 0]; % [cA_in cR_in cS_in]
tspan = [0 200];
% tspan = 0:0.01:50;
option = odeset;

%%Solver
[t, y] = ode45(@F1_cstr, tspan, y0, option, p); 
%[t, y] = ode45(@F1_batch, tspan, y0, option, p);

%% Plot
figure; % Neues Fenster für das Plot
hold on; % Alle Graphen im selben Fenster

% Konzentration von A, R und S über der Zeit plotten
plot(t, y(:, 1), 'r', 'LineWidth', 2); % cA in rot
plot(t, y(:, 2), 'g', 'LineWidth', 2); % cR in grün
plot(t, y(:, 3), 'b', 'LineWidth', 2); % cS in blau

% Achsenbeschriftungen und Titel
xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title('Konzentrationsverläufe der Spezies A, R und S', 'FontSize', 14);

% Legende hinzufügen
legend('cA (rot)', 'cR (grün)', 'cS (blau)', 'Location', 'northeast');

% Gitter anzeigen
grid on;

hold off; % Plot beenden

%%Plots