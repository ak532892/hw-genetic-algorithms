function [x] = popMem_alloc(N)
	x(N+1).genes = [];
    x(N+1).fitness = [];
    x(N+1).xvalue = [];
end