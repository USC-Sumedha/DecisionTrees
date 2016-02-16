function[] = genrateRuleTree(dtree)
for i = 1:numel(dtree)
    str1 = {''};
%     out = cell(1,22);
    if(size(dtree(i).child,1) == 0)
         out(i) = dtree(i).node;
         j = i;
       while(dtree(j).pind ~= 0)
           %if(strcmp(str1,'') == 1)
               str1 = strcat('(',dtree(j).parent,'=',dtree(j).parentLabel,')',{' '},'AND',{' '},str1);
          % end
            j = dtree(j).pind;
       end
       if(strcmp(dtree(i).inconsistent,'true') == 1)
            str1 = strcat('**IF',{' '},str1);
       else
           str1 = strcat('IF',{' '},str1);
       end
       str2 = cell2mat(str1);
       str1 = {str2(1:end-4)};
       str(i) = str1;
    end
    
end

ruletemp = strcat(str ,'THEN',{' '},'y',{' '},'=',{' '},out);
len = length(find(strcmp(ruletemp,'THEN y = ')==1));
ruleCell = ruletemp(1,len+1:end);
ruleCell = ruleCell';
ruleCell(length(ruleCell)+1,1) = {'NOTE : (**) - Define that output is approximated to highest class'};
fileID = fopen('rules.dat','w');
formatSpec = '%s\n';
[nrows,ncols] = size(ruleCell);

for row = 1:nrows
    fprintf(fileID,formatSpec,ruleCell{row,:});
end
fclose(fileID);
type rules.dat
end