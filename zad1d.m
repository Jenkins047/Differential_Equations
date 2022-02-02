clear;
h = 0.01;
clear;

H = [1 1e-1 1e-2 1e-3];
dy = @(t, y) -2*t*y;  

figure;
plt = 1;
maxerr = zeros(1,4);

for h=H
    t = 0:h:10;
    y = zeros(1,length(t));
    y(1) = 1;
    y_sol = exp(-t.^2);
    err = zeros(1,length(t));
    
    for k = 2:length(t)
        fn = dy(t(k-1), y(k-1));
        fn_2 = dy(t(k-1) + 0.5 * h, y(k-1) + 0.5 * h * fn);
        y(k) = y(k-1) + 0.5*h*(fn+fn_2);
        err(k) = abs(y_sol(k) - y(k));
    end
    maxerr(plt) = max(err);
    subplot (4,1,plt);
    plot(t,y);
    title("h = "+h);
    xlabel("t");
    ylabel("y");
    hold on;
    plot(t,y_sol);
    legend("y", "y_{sol}");
    hold off;
    plt = plt + 1;
end
figure;
loglog(H, maxerr, '-o');


clear;
H = [1 1e-1 1e-2 1e-3];
dy = @(t, y) -2*t*y; 

figure;
plt = 1;
maxerr = zeros(1,4);

dy = @(t,y) (4-2*y)/3;
for h=H
    t = 0:h:10;
    y = zeros(1,length(t));
    y(1) = 1;
    y_sol = 2*(1-exp(-2*(t/3)))+exp(-2*(t/3));
    err = zeros(1,length(t));
    
    for k = 2:length(t)
        fn = dy(t(k-1), y(k-1));
        fn_2 = dy(t(k-1) + 0.5 * h, y(k-1) + 0.5 * h * fn);
        y(k) = y(k-1) + 0.5*h*(fn+fn_2);
        err(k) = abs(y_sol(k) - y(k));
    end
    maxerr(plt) = max(err);

    subplot (4,1,plt);
    plot(t,y);
    title("h = "+h);
    xlabel("t");
    ylabel("y");
    hold on;
    plot(t,y_sol);
    legend("y", "y_{sol}");
    hold off;
    plt = plt + 1;
end
figure;
loglog(H, maxerr, '-o');



