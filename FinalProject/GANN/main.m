% Implement GANN
% Data source: http://archive.ics.uci.edu/ml/datasets/Iris
clc;
clearvars;
close all;
addpath realNumberBasicGA\
addpath inputData\

% Collect data
InputValue = load('bezdekIris.data1.txt');
global  numberOfInstance numberOfTraining h1neuron h2neuron outputNeuron P T Pt EPOCHS

numberOfInstance = 4;
h1neuron = input('第一層神經元個數: '); 
N1 = zeros(1, h1neuron);
h2neuron = input('第二層神經元個數: '); 
N2 = zeros(1, h2neuron);
outputNeuron = 3; O1 = zeros(1, outputNeuron);
numberOfTraining = 90;
EPOCHS = input('epoch: ');
numberOfTesting = 60;

% Normalize 0~1
for i = 1:numberOfInstance
    InputValue(:, i) = (InputValue(:, i) - min(InputValue(:, i))) ./ (max(InputValue(:, i)) - min(InputValue(:, i)));
end

% Training 
P(1:30, 1:numberOfInstance) = InputValue(1:30, 1:numberOfInstance);
P(31:60, 1:numberOfInstance) = InputValue(51:80, 1:numberOfInstance);
P(61:numberOfTraining, 1:numberOfInstance) = InputValue(101:130, 1:numberOfInstance);
T(1:30) = InputValue(1:30, 5);
T(31:60) = InputValue(51:80, 5);
T(61:numberOfTraining) = InputValue(101:130, 5);

% Initialize individual
global POPULATION_CNT geneLength CROSSOVER_RATE MUTATION_RATE
POPULATION_CNT = input('母群體數量: ');
CROSSOVER_RATE = 0.8;
MUTATION_RATE = 0.1; 

% gene (weights+bias)
geneLength = numberOfInstance*h1neuron+h1neuron + h1neuron*h2neuron+h2neuron + h2neuron*outputNeuron+outputNeuron;
[population, best_gene] = initialize();

% Testing 
Pt(1:20, 1:numberOfInstance) = InputValue(31:50, 1:numberOfInstance);
Pt(21:40, 1:numberOfInstance) = InputValue(81:100, 1:numberOfInstance); 
Pt(41:numberOfTesting, 1:numberOfInstance) = InputValue(131:150, 1:numberOfInstance);
Tt(1:20) = InputValue(31:50, 5);
Tt(21:40) = InputValue(81:100, 5);
Tt(41:numberOfTesting) = InputValue(131:150, 5);

fprintf('=========Training=========\n');

population(1) = cal_fitness_training(population(1));
best_gene(1) = population(1);
for i = 1:POPULATION_CNT
    population(i) = cal_fitness_training(population(i));
    %   更新best_gene
    if  (population(i).fitness < best_gene(1).fitness)
        best_gene(1) = population(i);
        population(POPULATION_CNT+1) = population(i);
    end
end
for iter = 1:EPOCHS
    pool = reproduction_rnd(population);        % 隨機(分配式)
    population = crossover(pool, population);   % 交配
    population = mutation(population);  % 突變
    for i = 1:POPULATION_CNT
        population(i) = cal_fitness_training(population(i));
        %   更新best_gene
        if  (population(i).fitness < best_gene(iter).fitness)
            best_gene(iter) = population(i);
            population(POPULATION_CNT+1) = population(i);
        end
    end
    [population, best_gene] = elitist(population, best_gene, iter);
end

result = zeros(1, numberOfTesting);
count = 0;
for iter = 1:numberOfTesting
    OutputValue = testing(best_gene(EPOCHS), iter);
    result(iter) = OutputValue;
    if OutputValue == Tt(iter)
        count = count + 1;
    end
end

figure;
plot([best_gene.fitness], 'ro-');
xlabel('Iteration times');
ylabel('Best fitness value');
title(['Convergence']);

figure;
accuracy = count / numberOfTesting * 100;
plot([Tt]);
hold on;
plot([result], 'ro');
legend('Target results','Classification results', 'Location', 'southoutside')
xlabel('Sample');
ylabel('Sort');
title(['Test accuracy = ', num2str(accuracy), '%']);

fprintf('=========Finish=========\n');
fprintf(['Test accuracy = ', num2str(accuracy), '%%\n']);
input('程式結束');