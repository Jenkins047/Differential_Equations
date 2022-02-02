clear;
R1= 1e3; %R1=1kohm
R2 = 1e3; %R2 = 1kohm
C1 = 10e-9; %C1 = 10nF
C2 = 2e-6; %C2 = 2uF
E = 2; %E0 = 2V;
du = @(t, u) [1/C1*( (E-u(1))/R1 - (u(1) - u(2))/R2 ); 1/(R2*C2) * (u(1) - u(2))];

A = [-1/(C1*R1) - 1/(C1*R2), 1/(C1*R2);
    1/(R2*C2), -1/(R2*C2)];
l = eig(A);
c1 = ( l(2)/(l(1)-l(2)) )*(E - ( (1+l(2)*R2*C2)/(l(2)*R2*C2) ));
c2 = -E-c1+1;
u2 = @(t) c1*exp(l(1)*t) + c2*exp(l(2)*t) + E;
[t1, y1] = ode45(du, [0 30e-3], [0 1]);
[t2, y2] = ode15s(du, [0 30e-3], [0; 1]);

y_sol = u2(t1);
disp("Maksymalny błąd rozwiązania ode45:" + max(abs(y1(:,2) - y_sol)));
disp("Liczba kroków czasowych ode45: 7281");

y_sol = u2(t2);
disp("Maksymalny błąd rozwiązania ode15:" + max(abs(y2(:,2) - y_sol)));
disp("Liczba kroków czasowych ode15: 55");
plot(t2,y_sol);
hold on;
plot(t2,y2(:,2));
