%% ------- CODE DIRECTORIES
addpath('tools');
addpath('method');
addpath('evaluation');

%% ------- DIRECTORY SETUP
options.run_name = '\17-06-2015\';
options.working_path = fullfile('..','data');
options.input= fullfile('..','data','input');
options.output= fullfile('..','data','output');
% Utility Path
options.vl_featPath= fullfile('thirdparties','vl_feat','vlfeat-0.9.18','toolbox');
options.libsvmPath= fullfile('thirdparties','libsvm','matlab');
options.pwmetricPath= fullfile('thirdparties','pwmetric');
options.liblinearPatch=fullfile('thirdparties','liblinear','matlab');

% if ispc
%     options.working_path = strrep(options.working_path, '/', '\');
%     options.input = strrep(options.input, '/', '\');
%     options.output = strrep(options.output, '/', '\');
%     options.vl_featPath = strrep(options.vl_featPath, '/', '\');
%     options.libsvmPath = strrep(options.addpath2, '/', '\');
%     options.pwmetricPath = strrep(options.pwmetricPath, '/', '\');
%     options.liblinearPatch = strrep(options.addpath4, '/', '\');
% end

addpath(genpath(options.libsvmPath));

%% ------- PYRAMID SETUP
options.trackletlength = 20;
options.pyaramidlevel = 4;
options.pyaramidnum = {1,2,4,10};
% kmeans clusters
options.numClusters = 100 ;
% dimention reduction
options.rdim = 100; 
% features dimention
options.legcnn = 4096;
% svm value
options.CC =[0.1 0.3 0.15 0.18 0.19 0.2 0.5 0.6 1 10 100 1000 10000 100000 1000000];
options.t = 0;

%% -------- KTH SETUP
% the name of set in each category for test
%options.datasetcat = [2,1];

%% -------- UCF101 Setup
options.ucfClassIndexFile = fullfile('..','data','ucfTrainTestlist','classInd.mat');
options.ucfAnnotationFile = fullfile('..','data','ucfTrainTestlist','annotation.mat');
