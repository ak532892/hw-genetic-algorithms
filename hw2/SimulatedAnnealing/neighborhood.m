function [rand_gene] = neighborhood(population)
    %   ВЅВа
    global GENETIC_LENGTH

    pool = popMem_alloc(GENETIC_LENGTH);
    pool(:) = population;
    for i = 1:GENETIC_LENGTH
        pool(i).genes(i) = ~pool(i).genes(i);
        pool(i) = cal_xvalue(pool(i));
        pool(i) = cal_fitness(pool(i));
    end
    rand_gene = pool(randperm(GENETIC_LENGTH, 1));
end