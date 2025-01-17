function [dydt] = F1_ident(t,y,p)

    dTdt = (k*A*(T_Oel2-T_in))/m*Cp_ks

    disp(['Zeit: ', num2str(t), ' T: ', num2str(T)]);

    dydt = [dTdt];
end