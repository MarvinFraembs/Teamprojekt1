clc;
clear all;
close all;

p.V_dot = 400 * 0.001 / 3600; % m^3 / s
p.cR_in = 350; % mol/m^3
p.k4 = 0.00005; % m^3 / (mol*s)
p.V_cstr = 1; %m^3
p.d_pftr = 0.125; %m
p.l_element = 1; %m

%%Solverparameter 
y0 = [p.cR_in 0]; % [cR_in cZ_in]
tspancstr = [0 : 1: 50000];
tspanpftr = [0 : 1: 4000];
option = odeset;

[t_cstr, y_cstr] = ode45(@(t, y) F2_cstr(t, y, p), tspancstr, y0); % Simulation CSTR
[t_pftr, y_pftr] = ode45(@(t, y) F2_pftr(t, y, p), tspanpftr, y0); % Simulation PFTR

% Berechnung CSTR
vwz_cstr = p.V_cstr / p.V_dot;
fprintf('VWZ: %.6f\n', vwz_cstr);

cR_cstr = y_cstr(:,1);
cZ_cstr = y_cstr(:,2);

molanteil = 0;

for i = 1:length(t_cstr)
    if t_cstr(i) == vwz_cstr
        molanteil = cZ_cstr(i) / (cR_cstr(i) + cZ_cstr(i));
        fprintf('Time: %.6f\n', t_cstr(i));
        fprintf('Molanteil: %.6f\n', molanteil);

        if molanteil > 0.95
            fprintf("Der verfügbare Rührkessel kann verwendet werden\n");
        else
            fprintf("Der verfügbare Rührkessel kann nicht verwendet werden\n");
        end

        break;  
    end
end

% Berechnung PFTR
cR_pftr = y_pftr(:,1);
cZ_pftr = y_pftr(:,2);

vwz_pftr = 0;

n_elements = 0;

A_pftr = pi * (p.d_pftr/2)^2;

for i = 1:length(t_pftr)
    molanteil = cZ_pftr(i) / (cR_pftr(i) + cZ_pftr(i));

    if molanteil > 0.95
        vwz_pftr = t_pftr(i);
        n_elements = (p.V_dot * vwz_pftr)/(A_pftr*p.l_element);
        n_elements = ceil(n_elements);  

        fprintf("Anzahl der PFTR-Elemente: %d\n", n_elements);

        break;
    end
end

%% Plot CSTR
figure; % Neues Fenster für den Plot
hold on; % Alle Graphen im selben Fenster

plot(t_cstr, y_cstr(:, 1), 'r', 'LineWidth', 2);
plot(t_cstr, y_cstr(:, 2), 'g', 'LineWidth', 2);

xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title('Konzentrationsverläufe der Spezies R und Z für den CSTR', 'FontSize', 14);

legend('cR (rot)', 'cZ (grün)', 'Location', 'northeast');

grid on;

hold off; 


%% Plot PFTR
figure; 
hold on; 

plot(t_pftr, y_pftr(:, 1), 'r', 'LineWidth', 2);
plot(t_pftr, y_pftr(:, 2), 'g', 'LineWidth', 2);

xlabel('Zeit (s)', 'FontSize', 12);
ylabel('Konzentration (mol/m^3)', 'FontSize', 12);
title('Konzentrationsverläufe der Spezies R und Z für den PFTR', 'FontSize', 14);

legend('cR (rot)', 'cZ (grün)', 'Location', 'northeast');

grid on;

hold off; 