function [x] = cal_fitness(x)
    %   ¾AÀ³¨ç¦¡
    global min2max 
    
    a = 1; b = 5.1 / (4*(pi)^2); c = 5 / pi; d = 6; e = 10; f = 1 / (8*pi);
    x1 = x.xvalue(1); x2 = x.xvalue(2);
    x.fitness = a * (x2 - b * (x1^2) + c * x1 - d)^2 + e * (1 - f) * cos(x1) + e;
    
    if min2max
        x.fitness = -x.fitness;
    end
end