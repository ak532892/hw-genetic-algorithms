function [x] = cal_fitness(x)
    %   ¾AÀ³¨ç¦¡
    global min2max 
    
    x1 = x.genes(1); x2 = x.genes(2);
    
    if (0 <= x1) && (x1 < 2)
        x.fitness = x2 + (10^-5) * ((x2-x1)^2) - 1;
    elseif (2 <= x1) && (x1 < 4)
        x.fitness = ((((x1-3)^2)-9) * (x2^3)) / (27*sqrt(3));
    elseif (4 <= x1) && (x1 <= 6)
        x.fitness = ((x1-2)^3) / 3 + x2 - 11 / 3;
    end
    
    if min2max
        x.fitness = -x.fitness;
    end
end