function[XH] = entropy(X,Y)
    [P,N] = prob(X,Y); 
    %features are along x-axis
    %classes are along y-axis
    %entropy = summation along column or y-axis
    % make all zero probabilities to 1 to avoid infitnity
    P(find(P == 0)) = 1;
    logP = log2(P);
    E = P.*logP;
    H = sum(E);
    temp = H .* N;
    XH = sum(temp,2); % total entropy of X
end