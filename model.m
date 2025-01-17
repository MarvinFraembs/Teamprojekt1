clc;
clear all;
close all;

%CSTR
p.F1_in = 1000/(3600*1000) % m^3/s
p.A = 6           % m^2
p.V = 0.1         % m^3
p.Tau = 300       % s
p.T_in = 293.15   % K
p.T_Oel1 = 353.15 % K
p.Cp_A = 2300     % J/mol*K
p.Cp_R = 2100     % J/mol*K
p.Cp_S = 2700     % J/mol*K
p.dh_1 = 10000    % J/mol
p.dh_2 = -10000   % J/mol
p.dh_3 = 14000    % J/mol
p.k1 = 0.007      % 1/s
p.k1 = 0.007      % 1/s
p.k1 = 0.0012     % 1/s
p.cA_in = 1000    % mol/m^3

%Prozessidentifikation

p.m_ks = 100      % kg
p.T_Oel2 = 350    % K
p.Cp_ks = 2500    % J/kg*K
p.kA = 1250/9     % W/(m^2*K)

%% Solver Prozessidentifikation

%Solverparameter
y0 = [p.T_in]; % [T_in]
tspanident = [0 500];
option = odeset;

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