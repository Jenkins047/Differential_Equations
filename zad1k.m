clear;
h = 0.01;
clear;

H = [1 1e-1 1e-2 1e-3];
dy = {@(t, y) -2*t*y, @(t, y) (4-2*y)/3};
sol = {@(t) exp(-t.^2), @(t) 2*(1 - exp(-2*(t/3))) + exp(-2*(t/3)) };

for m=1:2
    figure;
    plt = 1;
    maxerr = zeros(1,4);
    
    for h=H
        t = 0:h:10;
        y = zeros(1,length(t));
        y(1) = 1;
        y_sol = sol{m}(t);
        err = zeros(1,length(t));
        y(2) = y(1) + h*dy{m}(t(1), y(1));
        y(3) = y(2) + h*dy{m}(t(2), y(2));
        y(4) = y(3) + h*dy{m}(t(3), y(3));

        for k = 5:length(t)
            y(k) = (48*y(k-1) - 36*y(k-2) + 16*y(k-3) - 3*y(k-4)) / (25 + 24*h*t(k));
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
end