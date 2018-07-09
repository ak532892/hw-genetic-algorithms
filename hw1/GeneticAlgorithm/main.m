clc
clearvars

global min2max UNKNOWN_CNT GENETIC_LENGTH POPULATION_CNT ITER_CNT CROSSOVER_RATE MUTATION_RATE
% ����P�Ѽ�
% Max. fun

POPULATION_CNT = input('���s�ƶq: ');
ITER_CNT = input('���N����: ');

min2max = 1;                    % �ഫ��{���ܦ��D�ѳ̤j��
UNKNOWN_CNT = 2;                % ��������
GENETIC_LENGTH = 48;            % ��]����
% POPULATION_CNT = 300;           % ���s�ƶq
% ITER_CNT = 300;                % ���N����
CROSSOVER_RATE = 0.8;           % ��t�v
MUTATION_RATE = 0.1;            % ���ܲv

format long
tic;
iter = 1;
[population, best_gene] = initialize();
plotGeneration(iter, best_gene);
for iter = 2:ITER_CNT
%     pool = reproduction(population);            % ���(���t��)
    pool = reproduction_rnd(population);        % �H��(���t��)
    population = crossover(pool, population);   % ��t
    [population, best_gene] = mutation(population, best_gene, iter);  % ����
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

input('�{������');