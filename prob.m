function[P,XN] = prob(X,Y)
    UX = unique(X);
    UY = unique(Y);
    P = zeros(size(UY,1),size(UX,1));
    N = zeros(1,size(UX,1));
    for i = 1:size(UY,1)
        for j = 1:size(UX,1)
            % X == UX(j,1) --> returns where it is equal to one attribute
            % find(X == UX(j,1)) --> returns indices of this attribute in X
            % find(Y(find(X == UX(j,1)) --> returns indices of class where
            % this attribute is occuring
            P(i,j) = length(find(strcmp(Y(find(strcmp(X, UX(j,1)) == 1)),UY(i,1)) ==1))/length(find(strcmp(X,UX(j,1))==1));
            N(1,j) = length(find(strcmp(X,UX(j,1))==1));
        end    
    end 
    T = sum(N,2);
    XN = N/T;
end