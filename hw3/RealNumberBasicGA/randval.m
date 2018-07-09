function [val] = randval(low, high)
   val = rand * (high - low) + low;
end