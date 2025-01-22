function [dydt] = F1_cstr(t,y,p)

    T = y(1);
    cA = y(2);
    cR = y(3);
    cS = y(4);

    r1 = cA * p.k1;
    r2 = cR * p.k2;
    r3 = cA * p.k3;
    
    dTdt = (p.F1_in/p.V)*(p.cA_in*p.Cp_A/(cA*p.Cp_A+cR*p.Cp_R+cS*p.Cp_S))*(p.T_in-T)-(r3*p.dh_3)/(cA*p.Cp_A+cR*p.Cp_R+cS*p.Cp_S)-(r2*p.dh_2)/(cA*p.Cp_A+cR*p.Cp_R+cS*p.Cp_S)-(r1*p.dh_1)/(cA*p.Cp_A+cR*p.Cp_R+cS*p.Cp_S)+(p.Q/p.V)*1/(cA*p.Cp_A+cR*p.Cp_R+cS*p.Cp_S);
    dcAdt = p.F1_in/p.V * (p.cA_in - cA) - r1 + r2 - 2 * r3;
    dcRdt = -p.F1_in/p.V * cR + r1 - r2;
    dcSdt = -p.F1_in/p.V * cS + 2 * r3;

    disp(['Zeit: ', num2str(t), ' cA: ', num2str(cA), 'Temperatur:', num2str(T)]);

    dydt = [dTdt; dcAdt; dcRdt; dcSdt];
end