
dir_name = strrep(datestr(now), ':', '-');
dir_name = strrep(dir_name, ' ', '-');
dir_name = [dir_name '-acc_' num2str(mean(accResults)) '-clusters_' num2str(options.numClusters) '-overlap_' num2str(options.overlap) '-' report_end];

main_root = fullfile(options.report_dir,options.demo_alias, dir_name);
if ~exist(main_root,'dir')
     mkdir(main_root);
end
struct2File( options, fullfile(main_root,'options.txt'), 'sort', false ,'delimiter',' : ');
save (fullfile(main_root,'results.mat') , 'options', 'accResults', ...
      'allKCenters', 'allPcaData', 'allConf_line', 'allConf_lib');
  
 diary( fullfile(main_root,'command_window.txt'));
 diary off;
 diary('tmp.txt');

