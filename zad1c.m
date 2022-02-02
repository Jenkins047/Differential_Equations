clear;

H = [1 1e-1 1e-2 1e-3];
dy = @(t, y) -2*t*y;  

subplot(2,1,1);
plt = 1;
maxerr = zeros(1,4);

for h=H
    t = 0:h:10;
    y = zeros(1,length(t));
    y(1) = 1;
    y_sol = exp(-t.^2);
    err = zeros(1,length(t));
    
    for k = 2:length(t)
        y(k) = (y(k-1)-h*y(k-1)*t(k-1))/(1+h*t(k));
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

