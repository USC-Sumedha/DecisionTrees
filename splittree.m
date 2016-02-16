function[dtree,l] = splittree(output,columns)
%--------------------------------------------------------------------
Class = output(:,1);
Input = output(:,2:end);
dtree = struct('pind',{0},'inconsistent',{''},'parent',{'parent'},'parentLabel',{'null'},'node',{'currNode'},'child',struct('dtset',zeros,'label',{'test'}));
Entp = zeros(1,size(Input,2));
for k = 1:size(Input,2)
   Entp(1,k) = -entropy(Input(:,k),Class);
end
% find minimum
[M,I] = min(Entp);
sn = unique(Input(:,I));
%split all branches at this node
l = output(1,I+1);%fnode(data,output(1,I+1));
output(:,I+1) = [];
dtree.node = columns(I+1);
    for i = 1:size(sn,1)
        %create dataset for each branch for next split till there are no more
        %splits
        dtree.child(i).label = sn(i);
        dtree.child(i).dtset = output(find(strcmp(Input(:,I),sn(i)) == 1),:);
    end
end