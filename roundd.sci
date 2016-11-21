function [numd] = roundd(num,n)
    numd = round (num *10^n) / 10^n;
endfunction
