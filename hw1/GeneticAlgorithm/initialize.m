function [population, best_gene] = initialize
    %   初始化參數設定
    global SOL_CONSTRAIN POPULATION_CNT ITER_CNT GENETIC_LENGTH
    
    SOL_CONSTRAIN = [-5 10 0 15]; % 題目限制
    population = popMem_alloc(POPULATION_CNT);
    best_gene = popMem_alloc(ITER_CNT);

    for i = 1:POPULATION_CNT
        population(i).genes(:) = randi([0 1], 1, GENETIC_LENGTH);
        %   計算母體基因之進制值
        population(i) = cal_xvalue(population(i));
        %   計算母體對應之適應值
        population(i) = cal_fitness(population(i));

        %   更新best_gene
        if  (i == 1) || (population(i).fitness > best_gene(1).fitness)
            best_gene(1) = population(i);
        end
     end
end