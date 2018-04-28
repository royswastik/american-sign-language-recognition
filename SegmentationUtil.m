function sequencesResult = SegmentationUtil(sentenceData)
    sequencesResult = SegmentationUtilRecursive(sentenceData, len(sentenceData));
    sequencesResult2 = SegmentationUtilRecursiveReverse(sentenceData, len(sentenceData));
    sequencesResult = [sequencesResult; sequencesResult2];
end

function sequences = SegmentationUtilRecursive(sentenceData,n)
    sequences = [];
    SCORE_THRESHOLD = -0.02;     %This needs to be changed depending on the kind of classifier
    for i=7:7:n
        window = sentenceData(1, i+1);
        [label, score] = classifyLabel(window)
        if (score > SCORE_THRESHOLD)
            window = {window score(label)}      %Appending the score as the last element of each segment
            if (i >= n-5)
                sequences = [sequences ; window]
            else
                sequencesResultChild = SegmentationUtilRecursive(sentenceData(i, n-i+1), n-i+1);
                sequencesResult = [window sequencesResult];    %Append suffix sequence
                sequences = [sequences ;sequencesResult ];  %Add sequence to list of sequences
            end
        end
     end     
end


function sequences = SegmentationUtilRecursiveReverse(sentenceData,n)
    sequences = [];
    SCORE_THRESHOLD = -0.02;     %This needs to be changed depending on the kind of classifier
    for i=7:7:n
        window = sentenceData(n-1, n-i+1);
        [label, score] = classifyLabel(window)
        if (score > SCORE_THRESHOLD)
            window = {window score(label)}      %Appending the score as the last element of each segment
            if (i >= n-5)
                sequences = [sequences ; window]
            else
                sequencesResultChild = SegmentationUtilRecursiveReverse(sentenceData(1, i), n-i+1);
                sequencesResult = [sequencesResult window];    %Append suffix sequence
                sequences = [sequences ;sequencesResult ];  %Add sequence to list of sequences
            end
        end
     end     
end


function [label, score] = classifyLabel(sequenceData)
    f_acc_l = [EOS.maxFFT(sequenceData(1,:)), EOS.maxFFT(sequenceData(2,:)), EOS.maxFFT(sequenceData(3,:))];
    f_acc_r = [EOS.maxFFT(sequenceData(4,:)) EOS.maxFFT(sequenceData(5,:)) EOS.maxFFT(sequenceData(6,:)) ...
        EOS.waveform_length(sequenceData(4,:)) EOS.waveform_length(sequenceData(5,:)) EOS.waveform_length(sequenceData(6,:)) ...
        EOS.root_mean_square(sequenceData(4,:)) EOS.root_mean_square(sequenceData(5,:)) EOS.root_mean_square(sequenceData(6,:)) ...
        EOS.vector_mean(sequenceData(4,:), sequenceData(5,:), sequenceData(6,:)) EOS.vector_sd(sequenceData(4,:), sequenceData(5,:), sequenceData(6,:)) ... 
        EOS.mean_power_f(sequenceData(4,:)) EOS.mean_power_f(sequenceData(5,:))  EOS.mean_power_f(sequenceData(6,:)) ...
        EOS.sd_power_f(sequenceData(4,:))  EOS.sd_power_f(sequenceData(5,:))  EOS.sd_power_f(sequenceData(6,:)) ...
        EOS.energy_consumption(sequenceData(4,:)) EOS.energy_consumption(sequenceData(5,:)) EOS.energy_consumption(sequenceData(6,:)) ...  
        EOS.skew(sequenceData(4,:)) EOS.skew(sequenceData(5,:)) EOS.skew(sequenceData(6,:))  ...
        EOS.average_in_heading_direction(sequenceData(4,:), sequenceData(5,:), sequenceData(6,:))];

    f_emg_l = [EOS.maxFFT(sequenceData(7,:)) EOS.maxFFT(sequenceData(8,:)) EOS.maxFFT(sequenceData(9,:)) ...
        EOS.maxFFT(sequenceData(10,:)) EOS.maxFFT(sequenceData(11,:)) EOS.maxFFT(sequenceData(12,:)) ...
        EOS.maxFFT(sequenceData(13,:))];
    f_emg_r = [EOS.maxFFT(sequenceData(15,:)) EOS.maxFFT(sequenceData(16,:)) EOS.maxFFT(sequenceData(17,:)) ...
        EOS.maxFFT(sequenceData(18,:)) EOS.maxFFT(sequenceData(19,:)) EOS.maxFFT(sequenceData(20,:)) ...
        EOS.maxFFT(sequenceData(21,:))];
    f_gyro_l = [EOS.maxFFT(sequenceData(23,:)) EOS.maxFFT(sequenceData(24,:)) EOS.maxFFT(sequenceData(25,:))];
    f_gyro_r = [EOS.maxFFT(sequenceData(26,:)) EOS.maxFFT(sequenceData(27,:)) EOS.maxFFT(sequenceData(28,:)) ...
            EOS.waveform_length(sequenceData(26,:)) EOS.waveform_length(sequenceData(27,:)) EOS.waveform_length(sequenceData(28,:)) ...
            EOS.root_mean_square(sequenceData(26,:)) EOS.root_mean_square(sequenceData(27,:)) EOS.root_mean_square(sequenceData(28,:)) ...
            EOS.vector_mean(sequenceData(26,:), sequenceData(27,:), sequenceData(28,:)) ... 
            EOS.vector_sd(sequenceData(26,:), sequenceData(27,:), sequenceData(28,:)) ...
            EOS.mean_power_f(sequenceData(26,:)) EOS.mean_power_f(sequenceData(27,:))  EOS.mean_power_f(sequenceData(28,:)) ...
            EOS.sd_power_f(sequenceData(26,:)) EOS.sd_power_f(sequenceData(27,:)) EOS.sd_power_f(sequenceData(28,:)) ...
            EOS.energy_consumption(sequenceData(26,:)) EOS.energy_consumption(sequenceData(27,:)) EOS.energy_consumption(sequenceData(28,:)) ...
            EOS.skew(sequenceData(26,:)) EOS.skew(sequenceData(27,:)) EOS.skew(sequenceData(28,:)) ...
            EOS.average_in_heading_direction(sequenceData(26,:), sequenceData(27,:), sequenceData(28,:))];
    f_or_l = [EOS.maxFFT(sequenceData(29,:)) EOS.maxFFT(sequenceData(30,:)) EOS.maxFFT(sequenceData(31,:))];
    f_or_r = [EOS.maxFFT(sequenceData(32,:)) EOS.maxFFT(sequenceData(33,:)) EOS.maxFFT(sequenceData(34,:))];

    feature_row = [f_acc_l,f_acc_r, f_emg_l, f_emg_r, f_gyro_l, f_gyro_r, f_or_l, f_or_r];
    load('models/SVM_model');
    model = svm_model;
    [label, score] = predict(model,feature_row);
end