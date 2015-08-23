function [v_pca] = PcaData_sample(pca_sample,options)
legcnn = options.legcnn;
numf = size(pca_sample,2)/legcnn;
for jj =1:numf
    [~,~,V] = fsvd(pca_sample(:,((jj-1)*legcnn+1):(jj*legcnn)), options.rdim);
    v_pca{jj} = V;
end

