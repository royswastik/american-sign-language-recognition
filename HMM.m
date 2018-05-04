function [likelystates,accuracy] = HMM(trans_mat,emis_mat)

% we use hmmgenerate to  generate a random sequence of states and emissions
% of the model

[seq,states] = hmmgenerate(1000,TRANS,EMIS);

% seq = sequence of emissions , states = sequence of states.

%Given the transition and emission matrices TRANS and EMIS, the function hmmviterbi 
%uses the Viterbi algorithm to compute the most likely sequence of states the model 
%would go through to generate a given sequence seq of emissions.

likelystates = hmmviterbi(seq, TRANS, EMIS);

% this calculates the accuracy of the generated states
accuracy = sum(states==likelystates)/1000;

end

