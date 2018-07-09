function [population, best_gene] = elitist(population, best_gene, iter)
    global POPULATION_CNT UNKNOWN_CNT
    % 初始化 best_gene 用於比較
    best_gene(iter) = best_gene(iter-1);     
    
    best = population(1).fitness;
    best_mem = 1;
    worst = population(1).fitness;
    worst_mem = 1;

    for i = 2:POPULATION_CNT
        if population(i).fitness > best
            best = population(i).fitness;
            best_mem = i;
        elseif population(i).fitness < worst
            worst = population(i).fitness;
            worst_mem = i;
        end
    end
    
    if best > population(POPULATION_CNT+1).fitness
        for i = 1: UNKNOWN_CNT
            population(POPULATION_CNT+1).genes(i) = population(best_mem).genes(i);
        end
        population(POPULATION_CNT+1).fitness = population(best_mem).fitness;
    else
        for i = 1: UNKNOWN_CNT
            population(worst_mem).genes(i) = population(POPULATION_CNT+1).genes(i);
        end
        population(worst_mem).fitness = population(POPULATION_CNT+1).fitness;
    end
    
    %   再更新best_gene
     for i = 1:POPULATION_CNT
         if (population(i).fitness > best_gene(iter).fitness)
                best_gene(iter) = population(i);
        end
    end
end