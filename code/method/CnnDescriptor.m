function [cnn_feature_video] = CnnDescriptor(data,options)
cnn_feature_video =[];
if ~isfield(options,'pyramidType')
    options.pyramidType = 'sub';
end
%for frmnum =1:options.trackletlength:size(data,2)
for frmnum =1:(options.trackletlength-options.overlap):size(data,2)
    cnn_feature_pyramid =[];
    %------------------------------------------------
    if((size(data,2)>frmnum+options.trackletlength))
        for ii = 1:options.pyaramidlevel
            
            step_pyaramid = options.pyaramidnum(ii);
            trkend = min(size(data,2),frmnum+options.trackletlength);
            
            step = (frmnum-1):options.trackletlength/step_pyaramid:trkend;
            
            for jj =1 :length(step)-1
                cnn_feature_pyramid1=[];
                switch options.pyramidType
                    case 'sub'
                        cnn_feature_pyramid1= data(:,step(jj)+1) - data(:,step(jj+1));
                    case 'max'
                        cnn_feature_pyramid1= max(data(:,step(jj)+1) , data(:,step(jj+1)));
                    case 'sum'
                        cnn_feature_pyramid1= data(:,step(jj)+1) + data(:,step(jj+1)); 
                    case 'avg'
                        cnn_feature_pyramid1= mean(data(:,(step(jj)+1):step(jj+1)),2);
                    case 'maxall'
                        cnn_feature_pyramid1= max(data(:,(step(jj)+1):step(jj+1))')';
                end
%                 cnn_feature_pyramid1= sqrt(abs((data(:,step(jj)+1) - data(:,step(jj+1)))))/(norm((data(:,step(jj)+1) - data(:,step(jj+1))),2));
                cnn_feature_pyramid = [cnn_feature_pyramid,cnn_feature_pyramid1'];
            end
            
        end
        cnn_feature_video = [cnn_feature_video; cnn_feature_pyramid];
    end
end