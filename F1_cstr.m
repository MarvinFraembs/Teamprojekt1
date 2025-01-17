function [dydt] = F1_cstr(t,y,p)

    cA = y(1);
    cR = y(2);
    cS = y(3);

    r1 = cA * p.k1;
    r2 = cR * p.k2;
    r3 = cA * p.k3;
    
    dTdt = (F1_in/p.V)*(p.cA_in*p.Cp_A/(p.cA*p.Cp_A+p.cR*p.Cp_R+p.cS*p.Cp_S))*(p.T_in-p.T_Oel1)-(p.k3*p.dh_3)/(p.cA*p.Cp_A+p.cR*p.Cp_R+p.cS*p.Cp_S)+(p.dh_3/p.V)*1/(p.cA*p.Cp_A+p.cR*p.Cp_R+p.cS*p.Cp_S);
    dcAdt = p.F1_in/p.V * (p.cA_in - cA) - r1 + r2 - 2 * r3;
    dcRdt = -p.F1_in/p.V * cR + r1 - r2;
    dcSdt = -p.F1_in/p.V * cS + 2 * r3;

    disp(['Zeit: ', num2str(t), ' cA: ', num2str(cA)]);

    dydt = [dTdt; dcAdt; dcRdt; dcSdt];
end