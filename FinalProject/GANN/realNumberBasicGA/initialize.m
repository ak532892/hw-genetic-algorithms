function [population, best_gene] = initialize
    %   初始化參數設定
    global POPULATION_CNT EPOCHS geneLength
    
    population = popMem_alloc(POPULATION_CNT+1);
    best_gene = popMem_alloc(EPOCHS);
    
    for i = 1:POPULATION_CNT
        % 1~-1
        population(i).genes = rand(1, geneLength)*4-2;
     end
end