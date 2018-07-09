function plotGeneration(iter, population)
    global POPULATION_CNT
    if ((iter == 1) || (iter == 10) || (iter == 30) || (iter == 50) || (iter == 200))
        x1_1 = linspace(0, 2);
        x1_2 = linspace(2, 4);
        x1_3 = linspace(4, 6);
        
        x2_upper_1 = min(max(x1_1/sqrt(3), (-x1_1+6)/sqrt(3)));
        x2_upper_2 = min(max(x1_2/sqrt(3), (-x1_2+6)/sqrt(3)));
        x2_upper_3 = min(max(x1_3/sqrt(3), (-x1_3+6)/sqrt(3)));
        
        x2_1 = linspace(0, x2_upper_1);
        x2_2 = linspace(0, x2_upper_2);
        x2_3 = linspace(0, x2_upper_3);
        
        [X1_1, X2_1] = meshgrid(x1_1, x2_1);
        [X1_2, X2_2] = meshgrid(x1_2, x2_2);
        [X1_3, X2_3] = meshgrid(x1_3, x2_3);

        Z1 = X2_1 + (10^-5) .* ((X2_1-X1_1).^2) - 1;
        Z2 = ((((X1_2-3).^2)-9) .* X2_2.^3) / (27*sqrt(3));
        Z3 = ((X1_3-2).^3) ./ 3 + X2_3 - 11 / 3;

        for i = 1 : 100
            for j = 1 : 100
                if X2_1(i, j) > (min(X1_1(i, j)/sqrt(3), (-X1_1(i, j)+6)/sqrt(3)));
                    Z1(i, j) = 0;
                end
                if X2_2(i, j) > (min(X1_2(i, j)/sqrt(3), (-X1_2(i, j)+6)/sqrt(3)));
                    Z2(i, j) = 0;
                end
                if X2_3(i, j) > (min(X1_3(i, j)/sqrt(3), (-X1_3(i, j)+6)/sqrt(3)));
                    Z3(i, j) = 0;
                end
            end
        end
        
        figure;
        contour(X1_1, X2_1, Z1, 70);
        hold on;
        contour(X1_2, X2_2, Z2, 70);
        hold on;
        contour(X1_3, X2_3, Z3, 70);
        hold on;

        for i = 1:POPULATION_CNT
            plot(population(i).genes(1) , population(i).genes(2), 'r*');
        end
        title(['10 population ', num2str(iter), ' itaration']);
        xlabel('x_1');
        ylabel('x_2');
    end
end