function population = crossover(pool, population)
    %   ��t
    %   �o�̥u�Ҽ{����ӼƬ����ƭ�
    %   �Y����ӼƬ��_�ƭӻݦA���B�~�P�_�B�z,�_�h�o�ͰO����g�J���~�C
    global POPULATION_CNT GENETIC_LENGTH CROSSOVER_RATE
        
	cnt = 1;
    while(cnt < POPULATION_CNT)
		%   �H����G�ӭ���
        p = randperm(POPULATION_CNT, 2);
        pos1 = p(1); pos2 = p(2);
        
        %   �M�w�O�_��t
        crossover_if = rand(1);
        
        if (crossover_if > CROSSOVER_RATE)
			%   ����t, �N��t�����������^����
			population(cnt) = pool(pos1);
            population(cnt+1) = pool(pos2);
        else
            %   ���I��t, ��t����A��^����
            pos = randi([1 GENETIC_LENGTH-1]);
            
 			%   crossover
            population(cnt).genes(1:pos) = pool(pos1).genes(1:pos);
            population(cnt+1).genes(1:pos) = pool(pos2).genes(1:pos);

            population(cnt).genes(pos+1:GENETIC_LENGTH) = pool(pos2).genes(pos+1:GENETIC_LENGTH);
            population(cnt+1).genes(pos+1:GENETIC_LENGTH) = pool(pos1).genes(pos+1:GENETIC_LENGTH);
        end
        cnt = cnt+2; % �w�ƻs���G��
    end
end    