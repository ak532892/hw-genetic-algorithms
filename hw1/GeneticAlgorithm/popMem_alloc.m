function [x] = popMem_alloc(N)
	global GENETIC_LENGTH UNKNOWN_CNT

	x(N).genes = zeros(1, GENETIC_LENGTH);
    x(N).fitness = 0;
    x(N).xvalue = zeros(1, UNKNOWN_CNT);
end