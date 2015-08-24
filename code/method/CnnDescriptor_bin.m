function [cnn_feature_video] = CnnDescriptor_bin(data,trkM2,options)
cnn_feature_video =[];
%for frmnum =1:options.trackletlength:size(data,2)
indx = find(trkM2>0);
indxall = [1:length(trkM2)];

for frmnum =1:length(indx)-1
    %------------------------------------------------
    jj = frmnum+1;
    cnn_feature_pyramid =[];
    
    stp1 = (indxall(indx(jj)) - indxall(indx(frmnum)));
    while (stp1<=options.trackletlength && (length(indx)~=jj))
        jj = jj+1;
        stp1 = (indxall(indx(jj)) - indxall(indx(frmnum)));
        
    end
    
    if(stp1>options.trackletlength)
    stp1 = (indxall(indx(jj)-1) - indxall(indx(frmnum)));
        
        for ii = 1:options.pyaramidlevel
            
            step_pyaramid = options.pyaramidnum(ii);
            stp = ((stp1)/step_pyaramid);
            
            step = indxall(indx(frmnum)):stp:indxall(indx(jj)-1);
            
            for pnum =1 :length(step)-1
                cnn_feature_pyramid1=[];
                cnn_feature_pyramid1= data(:,floor(step(pnum))) - data(:,floor(step(pnum+1)));
                cnn_feature_pyramid = [cnn_feature_pyramid,cnn_feature_pyramid1'];
            end
            
        end
        cnn_feature_video = [cnn_feature_video; cnn_feature_pyramid];
    end
end
end

%------------------------------------------
% cnn_feature_video =[];
% %for frmnum =1:options.trackletlength:size(data,2)
%  indx = find(trkM2>0);
%  indxall = [1:length(trkM2)];
%
% for frmnum =1:length(indx)-1
% %------------------------------------------------
% for jj = frmnum+1:length(indx)
%         cnn_feature_pyramid =[];
%
%  stp1 = (indxall(indx(jj)) - indxall(indx(frmnum)));
% if (stp1>options.trackletlength)
% for ii = 1:options.pyaramidlevel
%
%    step_pyaramid = options.pyaramidnum{ii};
%    stp = ((stp1)/step_pyaramid);
%
%    step = indxall(indx(frmnum))-1:stp:indxall(indx(jj))-1;
%
%    for pnum =1 :length(step)-1
%         cnn_feature_pyramid1=[];
%         cnn_feature_pyramid1= data(:,floor(step(pnum))+1) - data(:,floor(step(pnum+1)));
%         cnn_feature_pyramid = [cnn_feature_pyramid,cnn_feature_pyramid1'];
%    end
%
% end
% cnn_feature_video = [cnn_feature_video; cnn_feature_pyramid];
% end
% end
% end