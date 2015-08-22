function  [tmpevideo] =  BinaryTrjectory(tmpe,options)

tmpevideo = [];
tmpe1 =[];
tmpe1 = [1;tmpe];
tmpe1(end) = 1;
 tmpevideo = [tmpevideo;tmpe1];

% tmpevideo = [];
% for i = 1:size(a,1)
%   indx1 = find(a(:,i) ==1);
%  tmpe =  [repmat(indx1(1),length(indx1),1),indx1];
%  tmpe(1,:)=[];
%  tmpevideo = [tmpevideo;tmpe];
% end