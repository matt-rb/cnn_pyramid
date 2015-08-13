function [cnn_feature_video] = CnnDescriptor(data,options)
cnn_feature_video =[];
%for frmnum =1:options.trackletlength:size(data,2)
for frmnum =1:(options.trackletlength-options.overlap):size(data,2)
    cnn_feature_pyramid =[];
    %------------------------------------------------
    if((size(data,2)>frmnum+options.trackletlength))
        for ii = 1:options.pyaramidlevel
            
            step_pyaramid = options.pyaramidnum{ii};
            trkend = min(size(data,2),frmnum+options.trackletlength);
            
            step = (frmnum-1):options.trackletlength/step_pyaramid:trkend;
            
            for jj =1 :length(step)-1
                cnn_feature_pyramid1=[];
                cnn_feature_pyramid1= data(:,step(jj)+1) - data(:,step(jj+1));
%                 cnn_feature_pyramid1= sqrt(abs((data(:,step(jj)+1) - data(:,step(jj+1)))))/(norm((data(:,step(jj)+1) - data(:,step(jj+1))),2));
                cnn_feature_pyramid = [cnn_feature_pyramid,cnn_feature_pyramid1'];
            end
            
        end
        cnn_feature_video = [cnn_feature_video; cnn_feature_pyramid];
    end
end