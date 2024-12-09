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
tspancstr = [0 200];
tspanbatch = [0 2000];
% tspan = 0:0.01:50;
option = odeset;

%%Solver
[t_cstr, y_cstr] = ode45(@F1_cstr, tspancstr, y0, option, p); 
[t_batch, y_batch] = ode45(@F1_batch, tspanbatch, y0, option, p);

%%Optimale Verweilzeit Batch Reaktor
cR = y_batch(:, 2); % Extrahieren von cR

% Finden des Maximums von cR
[cR_max, idx_max] = max(cR); % Maximum von cR und zugehörigen Index ermitteln
t_max_cR = t_batch(idx_max); % Zeitwert an der Stelle des Maximums

% Ergebnis ausgeben
fprintf('Das Maximum von cR (%.4f mol/m^3) wird bei t = %.2f Sekunden erreicht.\n', cR_max, t_max_cR);

%% Plot CSTR
figure; % Neues Fenster für das Plot
hold on; % Alle Graphen im selben Fenster

% Konzentration von A, R und S über der Zeit plotten
plot(t_cstr, y_cstr(:, 1), 'r', 'LineWidth', 2); % cA in rot
plot(t_cstr, y_cstr(:, 2), 'g', 'LineWidth', 2); % cR in grün
plot(t_cstr, y_cstr(:, 3), 'b', 'LineWidth', 2); % cS in blau

% Achsenbeschriftungen und Titel
xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title('Konzentrationsverläufe der Spezies A, R und S für den CSTR-Reaktor', 'FontSize', 14);

% Legende hinzufügen
legend('cA (rot)', 'cR (grün)', 'cS (blau)', 'Location', 'northeast');

% Gitter anzeigen
grid on;

hold off; % Plot beenden

%% Plot Batch
figure; % Neues Fenster für das Plot
hold on; % Alle Graphen im selben Fenster

% Konzentration von A, R und S über der Zeit plotten
plot(t_batch, y_batch(:, 1), 'r', 'LineWidth', 2); % cA in rot
plot(t_batch, y_batch(:, 2), 'g', 'LineWidth', 2); % cR in grün
plot(t_batch, y_batch(:, 3), 'b', 'LineWidth', 2); % cS in blau

% Achsenbeschriftungen und Titel
xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title('Konzentrationsverläufe der Spezies A, R und S für den Batch-Reaktor', 'FontSize', 14);

% Legende hinzufügen
legend('cA (rot)', 'cR (grün)', 'cS (blau)', 'Location', 'northeast');

% Gitter anzeigen
grid on;

hold off; % Plot beenden