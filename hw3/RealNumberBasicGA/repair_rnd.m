function [population] = repair_rnd(population) 
    % �׸ɡA�κ���constraint���覡���s���ͭ�
    global POPULATION_CNT SOL_CONSTRAIN
    
    for i = 1:POPULATION_CNT
        [vioCon] = violate_constraint(population(i));
        if ( vioCon )
            SOL_CONSTRAIN(4) = min(population(i).genes(1) / sqrt(3), (-population(i).genes(1)+6) / sqrt(3));
            population(i).genes(2) = randval(SOL_CONSTRAIN(3), SOL_CONSTRAIN(4));
        end
        %   �׸ɧ���A��@������A����
        population(i) = cal_fitness(population(i)); % �Nx�ȥN�J�A���禡
    end
    
end