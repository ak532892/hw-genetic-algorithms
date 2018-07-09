function population = crossover(pool, population)
    %   交配
    %   這裡只考慮母體個數為偶數個
    %   若母體個數為奇數個需再做額外判斷處理,否則發生記憶體寫入錯誤。
    global POPULATION_CNT GENETIC_LENGTH CROSSOVER_RATE
        
	cnt = 1;
    while(cnt < POPULATION_CNT)
		%   隨機選二個個體
        p = randperm(POPULATION_CNT, 2);
        pos1 = p(1); pos2 = p(2);
        
        %   決定是否交配
        crossover_if = rand(1);
        
        if (crossover_if > CROSSOVER_RATE)
			%   不交配, 將交配池中之個體丟回母體
			population(cnt) = pool(pos1);
            population(cnt+1) = pool(pos2);
        else
            %   單點交配, 交配完後再丟回母體
            pos = randi([1 GENETIC_LENGTH-1]);
            
 			%   crossover
            population(cnt).genes(1:pos) = pool(pos1).genes(1:pos);
            population(cnt+1).genes(1:pos) = pool(pos2).genes(1:pos);

            population(cnt).genes(pos+1:GENETIC_LENGTH) = pool(pos2).genes(pos+1:GENETIC_LENGTH);
            population(cnt+1).genes(pos+1:GENETIC_LENGTH) = pool(pos1).genes(pos+1:GENETIC_LENGTH);
        end
        cnt = cnt+2; % 已複製完二條
    end
end    