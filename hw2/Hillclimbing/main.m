clc
clearvars

global min2max UNKNOWN_CNT GENETIC_LENGTH POPULATION_CNT ITER_CNT
% 北ぃ把计
% Max. fun

ITER_CNT = input('Ω计: ');

% ITER_CNT = 200;                 % 程Ω计
min2max = 1;                    % 锣传よ祘Α跑Θ―秆程
UNKNOWN_CNT = 2;                % ゼ秆
GENETIC_LENGTH = 48;            % 膀
POPULATION_CNT = ITER_CNT;           % ダ竤计秖

format long
tic;
population = initialize();
ridx = randperm(ITER_CNT);
best_gene = popMem_alloc(ITER_CNT);

TF = true;
for iter = 1:ITER_CNT
    LOCAL = false;
    local_best_gene = popMem_alloc(50);
    vc = population(ridx(iter));
    k_iter = 1;
    local_best_gene(k_iter) = vc;
    while LOCAL == false
        k_iter = k_iter+1;
        pool_best_gene = neighborhood(vc);
        if (k_iter == 2) || (vc.fitness < pool_best_gene.fitness)
			vc = pool_best_gene;
            local_best_gene(k_iter) = pool_best_gene;
        else
            LOCAL = true;
        end
    end
    plotGeneration(local_best_gene, k_iter-2, TF);
    TF = false;
    
    if (iter == 1) || (best_gene(iter-1).fitness < vc.fitness)
        best_gene(iter) = vc;
    else
        best_gene(iter) = best_gene(iter-1);
    end
end
ALGOTime = toc;

fprintf('%3d times...\n', ITER_CNT);
 
if min2max
    for i = 1:ITER_CNT
        best_gene(i).fitness = -best_gene(i).fitness;
    end
end

fprintf('\n========================\n');
fprintf('best gene: ');
fprintf('(x1, x2) = (%.6f, %.6f)', best_gene(ITER_CNT).xvalue(1), best_gene(ITER_CNT).xvalue(2));
fprintf('\nbest fitness: ');
fprintf('%.6f \n', best_gene(ITER_CNT).fitness);
fprintf('CPU time = %.3f sec\n', ALGOTime);

figure;
plot([best_gene.fitness], 'ro-')
xlabel('Iteration times');
ylabel('Best fitness value');

input('祘Α挡');