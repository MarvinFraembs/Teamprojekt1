function [dydt] = F2_cstr(t,y,p)

    cR = y(1);
    cZ = y(2);

    % Annahme V_dotin = V_dotout
    dcRdt = p.V_dot/p.V_cstr * (p.cR_in - cR) - 2 * p.r;
    dcZdt = -p.V_dot/p.V_cstr * cZ + p.r;

    %disp(['Zeit: ', num2str(t), ' cR: ', num2str(cR)]);

    dydt = [dcRdt; dcZdt];
end