function [pool] = reproduction_rnd(population)
    %   �ƻs, ���L�����(�H����)
    global POPULATION_CNT min2max
    
    cumulative_fitness_prob = zeros(POPULATION_CNT, 1);
    
	%   �p��Ҧ��A�����`�X
    fitness_sum = sum([population(1:POPULATION_CNT).fitness]);
    
    cumulative_fitness_prob(1) = population(1).fitness/fitness_sum;
    for i = 2:POPULATION_CNT
        cumulative_fitness_prob(i) = cumulative_fitness_prob(i-1) + ...
            (population(i).fitness/fitness_sum);
    end
    
    if min2max
        div = (POPULATION_CNT-1);
        cumulative_fitness_prob(1) = (1 - population(1).fitness/fitness_sum) / div;
        for i = 2:POPULATION_CNT
            inverse_prob = (1 - population(i).fitness/fitness_sum);
            cumulative_fitness_prob(i) = cumulative_fitness_prob(i-1) + ...
               inverse_prob /div;
        end
    end
    
    pool = popMem_alloc(POPULATION_CNT);
	%   �p��C�ӥ������ƻs�X�Ө��t�����A�ê������ƻs
    for i = 1:POPULATION_CNT
        prob = rand;
        for pos = 1:POPULATION_CNT-1
            if prob <= cumulative_fitness_prob(pos)
                break;
            end
        end
        pool(i) = population(pos);
    end

end