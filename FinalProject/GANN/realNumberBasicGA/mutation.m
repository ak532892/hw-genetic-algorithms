function [population] = mutation(population)
    %	����
    global POPULATION_CNT MUTATION_RATE geneLength 
   
    for i = 1:POPULATION_CNT
        for pos = 1:geneLength % ���ܦ�m
            if (rand(1) <= MUTATION_RATE)
                population(i).genes(pos) = rand*4-2;
            end
        end
    end
    
end