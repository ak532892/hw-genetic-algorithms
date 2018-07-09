function [population, best_gene] = initialize
    %   ��l�ưѼƳ]�w
    global SOL_CONSTRAIN POPULATION_CNT ITER_CNT GENETIC_LENGTH
    
    SOL_CONSTRAIN = [-5 10 0 15]; % �D�ح���
    population = popMem_alloc(POPULATION_CNT);
    best_gene = popMem_alloc(ITER_CNT);

    for i = 1:POPULATION_CNT
        population(i).genes(:) = randi([0 1], 1, GENETIC_LENGTH);
        %   �p������]���i���
        population(i) = cal_xvalue(population(i));
        %   �p�����������A����
        population(i) = cal_fitness(population(i));

        %   ��sbest_gene
        if  (i == 1) || (population(i).fitness > best_gene(1).fitness)
            best_gene(1) = population(i);
        end
     end
end