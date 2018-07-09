clc
clearvars

global min2max UNKNOWN_CNT SOL_CONSTRAIN POPULATION_CNT ITER_CNT CROSSOVER_RATE MUTATION_RATE
% 北ぃ把计
% Max. fun
% Real number

POPULATION_CNT = input('ダ竤计秖: ');
ITER_CNT = input('Ω计: ');
SOL_CONSTRAIN = [0 6 0  ]; % 肈ヘ
min2max = 1;                    % 锣传よ祘Α跑Θ―秆程
UNKNOWN_CNT = 2;                % ゼ秆
% POPULATION_CNT = 10;           % ダ竤计秖
% ITER_CNT = 200;                % Ω计
CROSSOVER_RATE = 0.8;           % ユ皌瞯
MUTATION_RATE = 0.1;            % 跑瞯

format long
tic;
iter = 1;
[population, best_gene] = initialize();
plotGeneration(iter, population, POPULATION_CNT, true);
TF = true;
iter = iter+1;
while (iter <= ITER_CNT)
    pool = reproduction_rnd(population);        % 繦诀(だ皌Α)
    population = crossover(pool, population);   % ユ皌
    population = mutation(population);  % 跑
    population = repair_rnd(population);
    
    % hillclimbing
    LOCAL = false;
    local_best_gene = popMem_alloc(50);
    vc = population(POPULATION_CNT+1);
    k_iter = 1;
    local_best_gene(k_iter) = vc;
    while LOCAL == false
        pool_best_gene = neighborhood(vc, k_iter, TF);
        if (k_iter == 1) || (vc.fitness < pool_best_gene.fitness)
			vc = pool_best_gene;
            local_best_gene(k_iter) = pool_best_gene;
        else
            LOCAL = true;
        end
        k_iter = k_iter+1;
    end
    TF = false;
    population(POPULATION_CNT+1) = vc;
    [population, best_gene] = elitist(population, best_gene, iter);
    plotGeneration(iter, population, POPULATION_CNT, true);
    iter = iter+1;
end
ALGOTime = toc;

fprintf('%3d times...\n', iter);
iter = iter-1;
if min2max
    for i = 1:POPULATION_CNT+1
        population(i).fitness = -population(i).fitness;
    end
    for i = 1:iter
        best_gene(i).fitness = -best_gene(i).fitness;
    end
end

for i = 1:POPULATION_CNT
    fprintf('population %d : ', i);
    fprintf('(x1, x2) = (%.6f, %.6f)', population(i).genes(1), population(i).genes(2));
    fprintf('\tvalue = %.6f', population(i).fitness);
    fprintf('\n');
end
fprintf('\n========================\n');
fprintf('best gene: ');
fprintf('(x1, x2) = (%.6f, %.6f)', best_gene(iter).genes(1), best_gene(iter).genes(2));
fprintf('\nbest fitness: ');
fprintf('%.6f \n', best_gene(iter).fitness);
fprintf('CPU time = %.3f sec\n', ALGOTime);

figure;
plot([best_gene.fitness], 'ro-')
xlabel('Iteration times');
ylabel('Best fitness value');

input('祘Α挡');