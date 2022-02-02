clear;
R1= 1e3; %R1=1kohm
R2 = 11e3; %R2 = 1kohm
C1 = 2e-6; %C1 = 2uF
C2 = 3e-6; %C2 = 3uF
E = 10; %E0 = 10V;
tspan = [0 1];
y0 = [0; 1];
du = @(t, u) [1/C1*( (E-u(1))/R1 - (u(1) - u(2))/R2 ); 
            1/(R2*C2) * (u(1) - u(2))];

A = [-1/(C1*R1) - 1/(C1*R2), 1/(C1*R2);
    1/(R2*C2), -1/(R2*C2)];
b = [E/(R1*C1); 0];


H = [1e-2 1e-3 1e-4];
for h=H
    t = tspan(1):h:tspan(2);
    y = zeros(2,length(t));
    y(:,1) = y0;
    for k=2:length(t)
        y(:,k) = (eye(2) - h*A)\(y(:,k-1)+h*b); %metoda zamknięta Eulera  
    end
    figure
    plot(t,y);
end
