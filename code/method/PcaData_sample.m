function [v_pca] = PcaData_sample(pca_sample,options)
legcnn = options.legcnn;
numf = size(pca_sample,2)/legcnn;
disp('Compute PCA for sampled data');
if ~isfield(options,'pcaType')
    options.pcaType='fsvd';
end

dispstat ('','init');
v_pca = cell(1,numf);
for jj =1:numf
    if strcmp(options.pcaType,'fsvd')
        [~,~,V] = fsvd(pca_sample(:,((jj-1)*legcnn+1):(jj*legcnn)), options.rdim,2,true);
        dispstat (['PCA-fsvd level [' num2str(jj) ']/' num2str(numf) ]);
    else
        [~,V] = MyPCA(pca_sample(:,((jj-1)*legcnn+1):(jj*legcnn)),options);
        dispstat (['PCA-npca level [' num2str(jj) ']/' num2str(numf) ]);
    end
    v_pca{jj} = V;
    
end

