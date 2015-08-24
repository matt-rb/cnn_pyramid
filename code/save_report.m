
dir_name = strrep(datestr(now), ':', '-');
dir_name = strrep(dir_name, ' ', '-');

main_root = fullfile(options.report_dir,options.demo_alias, dir_name);
if ~exist(main_root,'dir')
     mkdir(main_root);
end
struct2File( options, fullfile(main_root,'options.txt'), 'sort', false ,'delimiter',' : ');

