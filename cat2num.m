function[x,val] = cat2num(data)
    %data = readtable(filename);
    b = data;
    x = zeros(size(b));
    val = {};
    for i = 1:size(data,2)
        Unq = unique(b(:,i));
        for j = 1:size(Unq,1)
            x(find(strcmp(b(:,i),Unq(j,1)) == 1),i) = j;
            val(j) = Unq(j,1);
        end
    end
end