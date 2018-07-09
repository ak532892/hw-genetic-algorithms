function [boolresult] = violate_constraint(population)
    boolresult = 0;
    if ( (population.genes(1) / sqrt(3) < population.genes(2)) || ...
         ((-population.genes(1)+6) / sqrt(3) < population.genes(2)) || ...
         (0 > population.genes(2)) )
        boolresult = 1; 
        return
    end
end