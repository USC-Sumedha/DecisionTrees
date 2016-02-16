% build tree - internally calls - generateTreeRules function and Splittree
% function
% Splittree calls probability and entropy functions
function[] = dtreeplot(dtree)
nlabel = {};
p = zeros(numel(dtree),1);
figure
for i = 1:numel(dtree)
       p(i,1)= dtree(i).pind;
        nlabel(i) = cellstr(strcat('',dtree(i).parentLabel));
end
 count = length(p)+1;
 % Adding leaf node to the parent nodes to have a clear graph
 % can ignore this step and just have labels for last parent nodes
for j = 1:numel(dtree)
   if(length(dtree(j).child) == 0)
        p(count,1) = j;
        count = count +1 ;
          nlabel(count) = cellstr(strcat('',dtree(j).node));
   end
end

 p = p';
 a = {[]};
nmlabel = nlabel';
%changing the parent node value (we set default to null in struct def)
nmlabel(find(strcmp(nmlabel,'null') == 1)) = cellstr('color');
% while adding the leaf nodes, the first index is empty. Remove it
    for i = 1:length(nmlabel)-1
        if(isempty(nmlabel{i}))
            nmlabel(i) = '';
        end
    end
% name1(23) = '';
 treeplot(p);
count = size(p,2);
[x,y] = treelayout(p);
x = x';
y = y';
text(x(:,1), y(:,1), nmlabel, 'VerticalAlignment','bottom','HorizontalAlignment','right')
title({'Level Lines'},'FontSize',12,'FontName','Times New Roman');
end