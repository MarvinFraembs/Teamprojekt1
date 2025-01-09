function [dydt] = F2_cstr(t,y,p)

    cR = y(1);
    cZ = y(2);

    r4 = cR^2 * p.k4;

    % Annahme V_dotin = V_dotout
    dcRdt = p.V_dot/p.V_cstr * (p.cR_in - cR) - 2 * r4;
    dcZdt = -p.V_dot/p.V_cstr * cZ + r4;

    %disp(['Zeit: ', num2str(t), ' cR: ', num2str(cR)]);

    dydt = [dcRdt; dcZdt];
end