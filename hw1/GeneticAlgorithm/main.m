clc
clearvars

global min2max UNKNOWN_CNT GENETIC_LENGTH POPULATION_CNT ITER_CNT CROSSOVER_RATE MUTATION_RATE
% 控制不同參數
% Max. fun

POPULATION_CNT = input('母群數量: ');
ITER_CNT = input('迭代次數: ');

min2max = 1;                    % 轉換方程式變成求解最大值
UNKNOWN_CNT = 2;                % 未知的解
GENETIC_LENGTH = 48;            % 基因長度
% POPULATION_CNT = 300;           % 母群數量
% ITER_CNT = 300;                % 迭代次數
CROSSOVER_RATE = 0.8;           % 交配率
MUTATION_RATE = 0.1;            % 突變率

format long
tic;
iter = 1;
[population, best_gene] = initialize();
plotGeneration(iter, best_gene);
for iter = 2:ITER_CNT
%     pool = reproduction(population);            % 選擇(分配式)
    pool = reproduction_rnd(population);        % 隨機(分配式)
    population = crossover(pool, population);   % 交配
    [population, best_gene] = mutation(population, best_gene, iter);  % 突變
    plotGeneration(iter, best_gene);
end
ALGOTime = toc;

fprintf('%3d times...\n', ITER_CNT);
if min2max
    for i = 1:POPULATION_CNT
        population(i).fitness = -population(i).fitness;
    end
    for i = 1:ITER_CNT
        best_gene(i).fitness = -best_gene(i).fitness;
    end
end

for i = 1:POPULATION_CNT
    fprintf('population %d : ', i);
    fprintf('(x1, x2) = (%.6f, %.6f)', population(i).xvalue(1), population(i).xvalue(2));
    fprintf('\tvalue = %.6f', population(i).fitness);
    fprintf('\n');
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

input('程式結束');