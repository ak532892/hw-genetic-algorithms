function [population] = mutation(population)
    %	¬ðÅÜ
    global POPULATION_CNT MUTATION_RATE UNKNOWN_CNT SOL_CONSTRAIN
   
    for i = 1:POPULATION_CNT
        for pos = 1:UNKNOWN_CNT % ¬ðÅÜ¦ì¸m
            mutation_if = rand(1);
            if (mutation_if <= MUTATION_RATE)
                if pos == 2
                    SOL_CONSTRAIN(2*pos) = min(population(i).genes(1)/sqrt(3), (-population(i).genes(1)+6)/sqrt(3));
                end
                population(i).genes(pos) = randval(SOL_CONSTRAIN(2*pos-1), SOL_CONSTRAIN(2*pos));
            end
        end
    end
    
end