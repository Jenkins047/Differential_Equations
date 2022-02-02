clear;

R1= 1e3; %R1=1kohm
R2 = 1e3; %R2 = 1kohm
C1 = 10e-9; %C1 = 10nF
C2 = 2e-6; %C2 = 2uF
E = [2 2]; %E0 = 2V;
du = @(t, u) [(1/C1) * ( (E(1) - u(1))/R1 - (u(1) - u(2))/R2 );
                1/(R2*C2)*(u(1) - u(2))];
tspan = [0 30e-3];
[t, y] = ode45(du, tspan, [0;1]);
[t2, y2] = ode15s(du, tspan, [0;1]);
plot(t, y(:,2));
hold on;
plot(t2, y2(:,2));

A = [-(1/R1) - 1/(C1*R2), -1/(C1*R2); 1/(R2*C2), -1/(R2*C2)];
l = eig(A);
c1 = l(2)/(l(1)-l(2))*(E(1) - (1+l(2)*R2*C2)/(l(2)*R2*C2));
c2 =  -E(1) - c1 + 1;
plot(t, c1*exp(l(1)*t)+c2*exp(l(2)*t)+E(1));
xlabel("t [s]");
ylabel("U [V]");
hold off;





    
 
   
