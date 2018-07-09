function [population, best_gene] = initialize
    %   初始化參數設定
    global SOL_CONSTRAIN POPULATION_CNT ITER_CNT UNKNOWN_CNT
    
    population = popMem_alloc(POPULATION_CNT+1);
    best_gene = popMem_alloc(ITER_CNT);

    for i = 1:POPULATION_CNT
        for j = 1:UNKNOWN_CNT
            if j == 2
                SOL_CONSTRAIN(2*j) = min(population(i).genes(j-1) / sqrt(3), (-population(i).genes(j-1)+6) / sqrt(3));
            end
            population(i).genes(j) = randval(SOL_CONSTRAIN(2*j-1), SOL_CONSTRAIN(2*j));
        end

        %   計算母體對應之適應值
        population(i) = cal_fitness(population(i));

        %   更新best_gene
        if  (i == 1) || (population(i).fitness > best_gene(1).fitness)
            best_gene(1) = population(i);
            population(POPULATION_CNT+1)= population(i);
        end
     end
end