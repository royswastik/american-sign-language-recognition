function sequencesResult = SegmentationUtil(sentenceData)
    sequencesResult = SegmentationUtilRecursive(sentenceData, len(sentenceData), []);
end

function sequencesResult = SegmentationUtilRecursive(sentenceData,n, resultVector)
    sequences = []
    newSegment = []
    SCORE_THRESHOLD = 0.6;
    for i=1:n
        prefix = sentenceData(1, i+1);
        [label, score] = classifyLabel(prefix)
        if (score > SCORE_THRESHOLD)
            if (i == n)
                newSegment = [newSegment prefix]
                resultVector = [resultVector newSegment];
                sequences = [sequences ; resultVector]
                sequencesResult = sequences
            end
            sequencesResult = SegmentationUtilRecursive(sentenceData(i, n-i+1), n-i+1,[resultVector + " "]);
        end
     end     
end


function [label, score] = classifyLabel(sequenceData)
%TODO

end