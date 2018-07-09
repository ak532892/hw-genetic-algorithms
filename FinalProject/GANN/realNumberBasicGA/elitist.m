function [population, best_gene] = elitist(population, best_gene, iter)
    global POPULATION_CNT
    
    best = population(1).fitness;
    best_mem = 1;
    worst = population(1).fitness;
    worst_mem = 1;

    for i = 2:POPULATION_CNT
        if population(i).fitness < best
            best = population(i).fitness;
            best_mem = i;
        elseif population(i).fitness > worst
            worst = population(i).fitness;
            worst_mem = i;
        end
    end

    if (isempty(population(POPULATION_CNT+1).fitness)==1)
        population(POPULATION_CNT+1).genes = population(best_mem).genes;
        population(POPULATION_CNT+1).fitness = population(best_mem).fitness;
    end
    if (best < population(POPULATION_CNT+1).fitness)
        population(POPULATION_CNT+1).genes = population(best_mem).genes;
        population(POPULATION_CNT+1).fitness = population(best_mem).fitness;
        best_gene(iter) = population(best_mem);
    else
        population(worst_mem).genes = population(POPULATION_CNT+1).genes;
        population(worst_mem).fitness = population(POPULATION_CNT+1).fitness;
        best_gene(iter) = population(POPULATION_CNT+1);
    end
end