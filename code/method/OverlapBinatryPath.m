function  [trkM] =  OverlapBinatryPath(data,index,options)


    C = sum( xor(data(index(1:end-1),:),data(index(2:end),:)),2);
    trkM=C>0;



% trkM = zeros(length(index),length(index));
% for ii =1:length(index)
%     C(:,ii) = sum( bsxfun(@xor,data(index(ii),:),data(index,:)),2);
%     trkM(ii,ii)=1;
%     for jj =ii:size(C,1)
%         if (C(ii,ii)-C(jj,ii)~=0 && (jj-ii)>20)
%             trkM(jj,ii) = 1;
%         end
%     end
% end
