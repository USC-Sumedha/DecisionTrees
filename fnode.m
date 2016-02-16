function[m] = fnode(data,label)
    output = table2cell(data);
    for i = 1:size(data,2)   
        if(length(find(strcmp(output(:,i),label) == 1)) > 0)
            m = data.Properties.VariableNames(i);
        end
    end
end