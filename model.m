clc;
clear all;
close all;

%CSTR
p.F1_in = 1000/(3600*1000); % m^3/s
p.A = 6;           % m^2
p.V = 0.1;         % m^3
p.T_in = 293.15;   % K
p.T_Oel1 = 353.15; % K
p.Cp_A = 2300;     % J/mol*K
p.Cp_R = 2100;     % J/mol*K
p.Cp_S = 2700;     % J/mol*K
p.dh_1 = 10000;    % J/mol
p.dh_2 = -10000;   % J/mol
p.dh_3 = 14000;    % J/mol
p.k1 = 0.007;      % 1/s
p.k2 = 0.007;      % 1/s
p.k3 = 0.0012;     % 1/s
p.cA_in = 1000;    % mol/m^3
p.kA = 1250/9;     % W/(m^2*K)
p.Q = p.A * (p.T_Oel1-p.T_in)*p.kA % W

%Prozessidentifikation

p.m_ks = 100;      % kg
p.T_Oel2 = 350;    % K
p.Cp_ks = 2500;    % J/kg*K
p.Tau = 300;       % s

%% Solver Prozessidentifikation

%Solverparameter
y0 = [p.T_in, p.cA_in, 0, 0]; % [T_in]
tspan = [0 4000];
option = odeset;

[t, y] = ode45(@(t, y) F1_cstr(t, y, p), tspan, y0);



%% Plot
figure; % Neues Fenster für das Plot
hold on; % Alle Graphen im selben Fenster

% Konzentration von A, R und S über der Zeit plotten
plot(t, y(:, 1), 'r', 'LineWidth', 2); % cA in rot
%plot(t, y(:, 2), 'g', 'LineWidth', 2); % cR in grün
%plot(t, y(:, 3), 'b', 'LineWidth', 2); % cS in blau

% Achsenbeschriftungen und Titel
xlabel('Zeit (s)', 'FontSize', 12);
xlim([0 5000]);
ylabel('Temperatur (Kelvin)/ Konzentration (mol/m^3)', 'FontSize', 12);
%title('Konzentrationsverläufe der Spezies A, R und S', 'FontSize', 14);

% Legende hinzufügen
%legend('cA (rot)', 'cR (grün)', 'cS (blau)', 'Location', 'northeast');

% Gitter anzeigen
grid on;

hold off; % Plot beenden
