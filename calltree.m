% Load fruits data
data = readtable('fruits_decisionTree.csv');
output = table2cell(data);

dtree = struct('pind',{0},'inconsistent',{'true'},'parent',{'parent'},'parentLabel',{'null'},'node',{'currNode'},'child',struct('dtset',zeros,'label',{'test'}));
ind = 1;
columns = {'Type','Length','Sweetness','Color'};

%Find first node to split and return the split tree
[dtree(ind),l] = splittree(output,columns);
dtree(ind).parent = 'null';
node = {};
x = ind;
while(x <= ind) 
    for i = 1:size(dtree(x).child,2)
        if(size(dtree(x).child(i).dtset,2) ~= 1)
            ind = ind+1;
            %Split recursively
            [dtree(ind),l] = splittree(dtree(x).child(i).dtset,columns);
            dtree(ind).parent = dtree(x).node;
            dtree(ind).parentLabel = dtree(x).child(i).label;
            dtree(ind).pind = x;
            dtree(ind).node = fnode(data,l);
        else
            if(size(dtree(x).child(i).dtset,1) ~= 1)
                % Leaf nodes with more than one values of same or different types in final
                % split
                ind = ind+1;
                colvec = dtree(x).child(i).dtset;
                [num,val] = cat2num(colvec);
                [modeNum,countNum] = mode(num);
                dtree(ind).pind = x;
                dtree(ind).node = val(modeNum);
                dtree(ind).parent = dtree(x).node;
                dtree(ind).parentLabel = dtree(x).child(i).label;
                if(countNum < size(dtree(x).child(i).dtset,1))
                    dtree(ind).inconsistent = 'true';
                else
                    dtree(ind).inconsistent = 'false'; 
                end
            else
                % Leaf nodes - pure
                ind = ind+1;
                dtree(ind).node = dtree(x).child(i).dtset(1);
                dtree(ind).parent = dtree(x).node;
                dtree(ind).parentLabel = dtree(x).child(i).label;
                dtree(ind).inconsistent = 'false';
                dtree(ind).pind = x;
            end
        end   
    end
    x = x +1 ;
end
genrateRuleTree(dtree);
dtreeplot;