addpath('tools');
addpath('method');
addpath('evaluation');

%% ------- Directory Setup
options.run_name = '\17-06-2015\';
options.working_path ='../data';
options.input='../data/input';
options.output='../data/output';
% Utility Path
options.vl_featPath='thirdparties/vl_feat/vlfeat-0.9.18/toolbox/';
options.libsvmPath='thirdparties/libsvm/matlab/';
options.pwmetricPath='thirdparties/pwmetric/';
options.liblinearPatch='thirdparties/liblinear/matlab/';

if ispc
    options.working_path = strrep(options.working_path, '/', '\');
    options.input = strrep(options.input, '/', '\');
    options.output = strrep(options.output, '/', '\');
    options.vl_featPath = strrep(options.vl_featPath, '/', '\');
    options.libsvmPath = strrep(options.addpath2, '/', '\');
    options.pwmetricPath = strrep(options.pwmetricPath, '/', '\');
    options.liblinearPatch = strrep(options.addpath4, '/', '\');
end

addpath(genpath(options.libsvmPath));

%% ------- Pyramid Setup
options.trackletlength = 20;
options.pyaramidlevel = 4;
options.pyaramidnum = {1,2,4,10};
% kmeans clusters
options.numClusters = 1000 ;
% dimention reduction
options.rdim = 100; 
% the name of set in each category for test
options.datasetcat = [2,1];
options.legcnn = 4096;
% svm value
options.CC =[0.1 0.3 0.15 0.18 0.19 0.2 0.5 0.6 1 10 100 1000 10000 100000 1000000];
options.t = 0;