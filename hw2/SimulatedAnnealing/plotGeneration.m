function plotGeneration(population, iter, TF)
    if (TF == true)
        x1 = linspace(-5, 10);
        x2 = linspace(0, 15);
        [X1, X2] = meshgrid(x1, x2);

        a = 1; b = 5.1 / (4*(pi)^2); c = 5 / pi; d = 6; e = 10; f = 1 / (8*pi);
        Z = a .* (X2 - b .* (X1.^2) + c .* X1 - d).^2 + e .* (1 - f) .* cos(X1) + e;
        figure;
        contour(X1, X2, Z, 30);
        hold on;
        for i = 1:iter
            t1(i) = population(i).xvalue(1);
            t2(i) = population(i).xvalue(2);
        end
        plot(t1, t2, 'r*-');
    end
end