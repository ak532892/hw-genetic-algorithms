function [population, best_gene] = mutation(population, best_gene, iter)
    %	突變
    global POPULATION_CNT MUTATION_RATE GENETIC_LENGTH
    
    % 初始化 best_gene 用於比較
    best_gene(iter) = best_gene(iter-1);
    for i = 1:POPULATION_CNT
        mutation_if = rand(1);
        
        if (mutation_if <= MUTATION_RATE)
			pos = randi([1 GENETIC_LENGTH]);    % 突變位置
			population(i).genes(pos) =  ~population(i).genes(pos);
        end
        %   突變完後再算一次母體適應值
		population(i) = cal_xvalue(population(i));  % 先算基因對應之進制x值
		population(i) = cal_fitness(population(i)); % 再將進制x值代入適應函式
		
        %   再更新best_gene
        if (population(i).fitness > best_gene(iter).fitness)
			best_gene(iter) = population(i);
        end
    end
end