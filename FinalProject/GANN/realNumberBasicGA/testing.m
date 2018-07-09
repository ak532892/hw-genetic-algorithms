function index = testing(x, iter)
    %   ¾AÀ³¨ç¦¡
    global numberOfInstance h1neuron h2neuron outputNeuron Pt 
    
    gene = x.genes;
    in = Pt(iter, 1:numberOfInstance);
    N1 = zeros(1, h1neuron); N2 = zeros(1, h2neuron); O1 = zeros(1, outputNeuron);

    for h1 = 1:h1neuron
        gene_st = 1+(h1-1)*(numberOfInstance+1);
        N1(h1) = tansig( sum(in.*gene(gene_st : gene_st+numberOfInstance-1)) + gene(gene_st+numberOfInstance) );
    end
    shift = gene_st + numberOfInstance;

    for h2 = 1:h2neuron
        gene_st = shift+1+(h2-1)*(h1neuron+1);
        N2(h2) = logsig( sum(N1(1:h1neuron).*gene(gene_st : gene_st+h1neuron-1)) + gene(gene_st+h1neuron) );
    end
    shift = gene_st + h1neuron;

    for o1 = 1:outputNeuron
        gene_st = shift+1+(o1-1)*(h2neuron+1);
        O1(o1) = purelin( sum(N2(1:h2neuron).*gene(gene_st : gene_st+h2neuron-1)) + gene(gene_st+h2neuron) );
    end
    
    O1 = O1';
    O1 = softmax(O1);
    
    [~, index] = max(O1);
end