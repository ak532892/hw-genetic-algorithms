function [population] = repair_rnd(population) 
    % 修補，用滿足constraint的方式重新產生值
    global POPULATION_CNT SOL_CONSTRAIN
    
    for i = 1:POPULATION_CNT
        [vioCon] = violate_constraint(population(i));
        if ( vioCon )
            SOL_CONSTRAIN(4) = min(population(i).genes(1) / sqrt(3), (-population(i).genes(1)+6) / sqrt(3));
            population(i).genes(2) = randval(SOL_CONSTRAIN(3), SOL_CONSTRAIN(4));
        end
        %   修補完後再算一次母體適應值
        population(i) = cal_fitness(population(i)); % 將x值代入適應函式
    end
    
end