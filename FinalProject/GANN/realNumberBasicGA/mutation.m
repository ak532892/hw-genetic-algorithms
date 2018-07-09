function [population] = mutation(population)
    %	¬ðÅÜ
    global POPULATION_CNT MUTATION_RATE geneLength 
   
    for i = 1:POPULATION_CNT
        for pos = 1:geneLength % ¬ðÅÜ¦ì¸m
            if (rand(1) <= MUTATION_RATE)
                population(i).genes(pos) = rand*4-2;
            end
        end
    end
    
end