function [x] = cal_xvalue(x)
    global UNKNOWN_CNT SOL_CONSTRAIN

    m = [24 24];      % 由題目算出來Binary string的m1跟m2要怎麼切割
    % binary to dec
    for i = 1:UNKNOWN_CNT
        if i == 1
            x.xvalue(i) = bi2de(fliplr(x.genes(1:m(i))));
        else
            x.xvalue(i) = bi2de(fliplr(x.genes( sum(m(1:i-1))+1 : sum(m(1:i)) )));
        end
    end
    
    % Decoding
    for i = 1:UNKNOWN_CNT
        a = SOL_CONSTRAIN(i*2-1);
        b = SOL_CONSTRAIN(i*2);
        x.xvalue(i) = a + x.xvalue(i)*( (b-a) / (2^m(i)-1) );
    end
end