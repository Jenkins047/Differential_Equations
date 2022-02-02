clear;
R1= 1e3; %R1=1kohm
R2 = 1e3; %R2 = 1kohm
C1 = 10e-9; %C1 = 10nF
C2 = 2e-6; %C2 = 2uF
E = 2; %E0 = 2V;
tspan = [0 30e-3];
y0 = [0; 1];
du = @(t, u) [1/C1*( (E-u(1))/R1 - (u(1) - u(2))/R2 ); 
            1/(R2*C2) * (u(1) - u(2))];

A = [-1/(C1*R1) - 1/(C1*R2), 1/(C1*R2);
    1/(R2*C2), -1/(R2*C2)];
l = eig(A);
c1 = ( l(2)/(l(1)-l(2)) )*(E - ( (1+l(2)*R2*C2)/(l(2)*R2*C2) ));
c2 = -E-c1+1;
u2 = @(t) c1*exp(l(1)*t) + c2*exp(l(2)*t) + E;
tolerance = [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6];
maxerr = zeros(2, length(tolerance));
index = 1;
for t = tolerance
    [t1, y1] = ode45(du, tspan, y0);
    [t2, y2] = ode15s(du, tspan, y0);
    plot(t1, y1(:,2));
    hold on;
    plot(t2, y2(:,2));
    hold off;
    maxerr(1, index) = max( abs(y1(:,2) - u2(t1)) );
    maxerr(2, index) = max( abs(y2(:,2) - u2(t2)) );
end

subplot(2,1,1);
semilogx(tolerance, maxerr(1,:));
title("ode45");
xlabel("Tolerance");
ylabel("MaxError");
subplot(2,1,2);
semilogx(tolerance, maxerr(2,:));
title("ode15s");
xlabel("Tolerance");
ylabel("MaxErr");