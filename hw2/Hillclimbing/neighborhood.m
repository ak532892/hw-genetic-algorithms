function [best_gene] = neighborhood(population)
    %   ВЅВа
    global GENETIC_LENGTH 

	% ??????4bit, 2????8bit
    pool = popMem_alloc(GENETIC_LENGTH);
    pool(:) = population;
    
    for i = 1:GENETIC_LENGTH
        pool(i).genes(i) = ~pool(i).genes(i);
        pool(i) = cal_xvalue(pool(i));
        pool(i) = cal_fitness(pool(i));
    end
    
     [~, I] = sort([pool.fitness], 'descend');
%      [~, I] = max([pool.fitness]);
     best_gene = pool(I(2));
end