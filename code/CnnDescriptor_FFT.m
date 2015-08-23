function [cnn_feature_video] = CnnDescriptor_FFT(data,options)
cnn_feature_video =[];
for frmnum =1:(options.trackletlength-options.overlap):size(data,2)
    cnn_feature_pyramid =[];
    trkend = min(size(data,2),frmnum+options.trackletlength);
    step = (frmnum):options.trackletlength:trkend;
    cnn_feature_pyramid1 = fft(data(:,step(1):step(2)+1)');
    %------------------------------------------------
    if((size(data,2)>frmnum+options.trackletlength))
        for ii = 1:options.pyaramidlevel
            cnn_feature_pyramid = [cnn_feature_pyramid, real(cnn_feature_pyramid1(ii+1,:)), imag(cnn_feature_pyramid1(ii+1,:))];
        end
        cnn_feature_video = [cnn_feature_video; cnn_feature_pyramid];
    end
end