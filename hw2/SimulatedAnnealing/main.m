clc
clearvars

global min2max UNKNOWN_CNT GENETIC_LENGTH POPULATION_CNT ITER_CNT
% 北ぃ把计
% Max. fun

% ITER_CNT = input('Ω计: ');

ITER_CNT = 200;                 % 程Ω计
min2max = 1;                    % 锣传よ祘Α跑Θ―秆程
UNKNOWN_CNT = 2;                % ゼ秆
GENETIC_LENGTH = 48;            % 膀
% POPULATION_CNT = ITER_CNT;           % ダ竤计秖
% ITER_CNT = 200;                % Ω计

format long
tic;

TF = false;
T = 1;
Tend = 10^-6;
alpha = 0.1;
iter = 0;
THcool = 50;
tmp = round(alpha/Tend);
num = 0;
while tmp >= 1
    tmp = tmp/10;
    num = num+1;
end
num = num*THcool;
if ITER_CNT < num, num = ITER_CNT ; end
POPULATION_CNT = num;
population = initialize();
best_gene = popMem_alloc(POPULATION_CNT);
ridx = randperm(POPULATION_CNT);
while (iter < ITER_CNT) && ((T > Tend) && ((abs(T - Tend) > 1e-8)))
    iter = iter+1;
    local_best_gene = popMem_alloc(10);
    vc = population(ridx(iter));
    k_iter = 1;
    local_best_gene(k_iter) = vc;
    while k_iter <= 10
        k_iter = k_iter+1;
        pool_rand_gene = neighborhood(vc);
        if (k_iter == 2) || (vc.fitness < pool_rand_gene.fitness)
			vc = pool_rand_gene;
        elseif rand < exp((pool_rand_gene.fitness-vc.fitness) / T)
            vc = pool_rand_gene;
        end
        local_best_gene(k_iter) = vc;
    end
    plotGeneration(local_best_gene, k_iter, TF);
    
    if (iter == 1) || (best_gene(iter-1).fitness < vc.fitness)
        best_gene(iter) = vc;
    else
        best_gene(iter) = best_gene(iter-1);
    end
    if mod(iter, THcool) == 0
        T = T * alpha;
    end
end
ALGOTime = toc;

fprintf('%3d times...\n', iter);
 
if min2max
    for i = 1:iter
        best_gene(i).fitness = -best_gene(i).fitness;
    end
end

fprintf('\n========================\n');
fprintf('best gene: ');
fprintf('(x1, x2) = (%.6f, %.6f)', best_gene(iter).xvalue(1), best_gene(iter).xvalue(2));
fprintf('\nbest fitness: ');
fprintf('%.6f \n', best_gene(iter).fitness);
fprintf('CPU time = %.3f sec\n', ALGOTime);

% figure;
% plot([best_gene.fitness], 'ro-')
% xlabel('Iteration times');
% ylabel('Best fitness value');

% input('祘Α挡');