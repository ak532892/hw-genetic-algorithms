function [best_gene] = neighborhood(population, iter, TF)
    dir = 4;

    pool = popMem_alloc(dir); % north, south, west, east
    pool(:) = population;
    
    pool(1).genes(2) = pool(1).genes(2) + 0.01;
    pool(2).genes(2) = pool(2).genes(2) - 0.01;
    pool(3).genes(1) = pool(3).genes(1) - 0.01;
    pool(4).genes(1) = pool(4).genes(1) + 0.01;
    
    i = 1;
    while i <= dir
        [vioCon] = violate_constraint(pool(i));
        if( vioCon )
            pool(i) = [];
            dir = dir-1;
            continue;
        end
        pool(i) = cal_fitness(pool(i));
        i = i+1;
    end
    
    plotGeneration2(iter, pool, dir, TF);
    
    [~, I] = max([pool.fitness]);
    best_gene  = pool(I);
end