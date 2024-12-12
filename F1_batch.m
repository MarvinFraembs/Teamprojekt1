function [dydt] = F1_batch(t,y,p)

    cA = y(1);
    cR = y(2);
    cS = y(3);

    r1 = cA * p.k1;
    r2 = cR * p.k2;
    r3 = cS * p.k3;

    dcAdt = -r1 + r2 - r3;
    dcRdt = r1 - r2;
    dcSdt = 2 * r3;

    dydt = [dcAdt, dcRdt, dcSdt]';
end