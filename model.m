clc;
clear all;
close all;

p.k1 = 0.007;                   % 1/s
p.k2 = 0.007;                   % 1/s
p.k3 = 0.0012;                  % 1/s
p.V = 0.1;                      % m^3
p.cA_in = 1000;                 % mol/m^3
volumenstroeme = [10000, 1000, 100, 10] / (3600 * 1000); % Liste der Volumenströme (m^3/s)

%%Solverparameter 
y0 = [p.cA_in 0 0]; % [cA_in cR_in cS_in]
tspancstr = [0 200];
tspanbatch = [0 2000];
% tspan = 0:0.01:50;
option = odeset;

%% Optimaler Volumenstrom

% Speicher für Ergebnisse
max_cR_cstr_values = []; % Maxima von cR
optimal_F = [];     % Volumenstrom mit dem größten Maximum von cR

% Simulation für jeden Volumenstrom
for i = 1:length(volumenstroeme)
    p.F1_in = volumenstroeme(i); % Setzen des aktuellen Volumenstroms
    [t_cstr, y_cstr] = ode45(@F1_cstr, tspancstr, y0, option, p); % Simulation
    
    cR_cstr = y_cstr(:, 2); % Konzentration cR extrahieren
    [cR_cstr_max, idx_max] = max(cR_cstr); % Maximum von cR finden
    max_cR_cstr_values(end + 1) = cR_cstr_max; % Speichern des Maximums
    
    % Ergebnis ausgeben
    fprintf('Volumenstrom F = %.10f m^3/s, Maximum von cR = %.5f mol/m^3\n', ...
            volumenstroeme(i), cR_cstr_max);
end

% Optimalen Volumenstrom finden
[optimal_cR_cstr_max, optimal_idx] = max(max_cR_cstr_values);
optimal_F = volumenstroeme(optimal_idx);

%% Simulation mit dem optimalen Volumenstrom
p.F1_in = optimal_F; % Setzen des optimalen Volumenstroms
[t_cstr_opt, y_cstr_opt] = ode45(@F1_cstr, tspancstr, y0, option, p);

% Ergebnis ausgeben
fprintf('\nDer optimale Volumenstrom ist F = %.10f m^3/s mit cR_max = %.5f mol/m^3.\n', ...
        optimal_F, optimal_cR_cstr_max);

%%Solver Batch Reaktor 
[t_batch, y_batch] = ode45(@F1_batch, tspanbatch, y0, option, p);

%%Optimale Verweilzeit Batch Reaktor
cR_batch = y_batch(:, 2); % Extrahieren von cR

% Finden des Maximums von cR
[cR_batch_max, idx_max] = max(cR_batch); % Maximum von cR und zugehörigen Index ermitteln
t_max_cR_batch = t_batch(idx_max); % Zeitwert an der Stelle des Maximums

% Ergebnis ausgeben
fprintf('Das Maximum von cR (%.4f mol/m^3) wird bei t = %.2f Sekunden erreicht.\n', cR_batch_max, t_max_cR_batch);

%% Plot CSTR
figure; % Neues Fenster für das Plot
hold on; % Alle Graphen im selben Fenster

% Konzentration von A, R und S über der Zeit plotten
plot(t_cstr_opt, y_cstr_opt(:, 1), 'r', 'LineWidth', 2); % cA in rot
plot(t_cstr_opt, y_cstr_opt(:, 2), 'g', 'LineWidth', 2); % cR in grün
plot(t_cstr_opt, y_cstr_opt(:, 3), 'b', 'LineWidth', 2); % cS in blau

% Achsenbeschriftungen und Titel
xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title({'Konzentrationsverläufe der Spezies A, R und S für den CSTR-Reaktor', ...
       'mit dem Volumenstrom von 10 l/h'}, 'FontSize', 14);

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