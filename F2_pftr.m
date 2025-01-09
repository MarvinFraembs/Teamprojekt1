function [dydt] = F2_pftr(t,y,p)

    cR = y(1);
    cZ = y(2);

    r4 = cR * p.k4

    dcRdt = -2 * r4;
    dcZdt = r4;

    dydt = [dcRdt, dcZdt]';
end