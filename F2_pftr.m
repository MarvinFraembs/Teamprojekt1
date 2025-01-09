function [dydt] = F2_pftr(t,y,p)

    cR = y(1);
    cZ = y(2);

    dcRdt = -2 * p.r;
    dcZdt = p.r;

    dydt = [dcRdt, dcZdt]';
end