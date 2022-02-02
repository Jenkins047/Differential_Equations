clear;
H = logspace(-5, 0);
dy = @(t, y) -2*t*y;  

plt = 1;
maxerr = zeros(1,4);

for h=H
    t = 0:h:10;
    y = zeros(1,length(t));
    y(1) = 1;
    y1(1) = 1;
    y_sol = exp(-t.^2);
    err = zeros(1,length(t));
    err1 = zeros(1,length(t));
    
    for k = 2:length(t)
        y(k) = y(k-1) + h*dy(t(k-1), y(k-1));%
        y1(k) = y1(k-1) + h*0.5*( dy(t(k-1), y1(k-1)) + dy(t(k), y1(k-1) +h*dy(t(k-1), y1(k-1)) ));
        err(k) = abs(y_sol(k) - y(k));
        err1(k) = abs(y_sol(k) - y1(k));
    end
    maxerr(plt) = max(err);
    maxerr1(plt) = max(err1);
    plt = plt + 1;
end
figure;
loglog(H, maxerr, '-o');
figure
loglog(H, maxerr1, '-o');

