function [F,number_of_matches,mcs,mgt] = fox_pairing_frames(...
    matchMatrix,threshold,pairingMethod)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% matchMatrix: matrix with the pairwise *distances* between the frames of
% summaries A and B. The size of the matrix is M-by-N where M is the number
% of frames in summary A, and N is the number of frames in summary B.
%
%+++++ Note: A is the candidate summary and B is the ground truth.+++++
%
% threshold: values in matchMatrix smaller than threshold are declared
%            matches
% pairingMethod: must be one of the following [1,2]
%                   1: Naive Matching
%                   2: Greedy Matching
%                   3: Hungarian Matching
%                   4: Mahmoud Method
%                   5: Kannappan Method
%                   6: Maximal Matching (Hopcroft-Karp)
% Output
%
% F: F-measure
% number_of_mathces: number of matched frames
% mcs: indices of matched frames from the candidate summary
% mgt: indices of matched frames from the groun truth
%
% -------------
% [1] Kuncheva L. I., P. Yousefi and I. A. D. Gunn, On the Evaluation
% of Video Keyframe Summaries using User Ground Truth,
% arXiv:1712.06899, 2017.
%
% [2] Gunn I. A. D., L. I. Kuncheva, and P. Yousefi, Bipartite Graph
% Matching for Keyframe Summary Evaluation, arXiv:1712.06914, 2017.
%==========================================================================
% Author: Lucy Kuncheva

%#ok<*FNDSB>
%#ok<*UDIM>
M = matchMatrix;
[sA,sB] = size(M);
mcs = []; mgt = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch pairingMethod
    case 1 % Naive (no elimination)
        % Note: A is candidate, B is ground truth!
        number_of_matches = min(...
            [sum(min(M') < threshold),sA,sB]);
        for i = 1:sA
            [mi,inmi] = min(M(i,:));
            if mi < threshold
                mcs = [mcs;i]; mgt = [mgt;inmi];
            end
        end
    case 2 %'Greedy'
        number_of_matches = 0;
        dmin = min(M(:)); % minimum distance at joining
        while dmin < threshold
            [x,y] = find(M == dmin); % find the match
            number_of_matches = number_of_matches + 1;
            M(x(1),:) = inf;
            M(:,y(1)) = inf;
            dmin = min(M(:));
            mcs = [mcs;x(1)]; mgt = [mgt;y(1)];
        end
    case 3 %'Hungarian'
        [Org,~] = assignment_hungarian(M);
        number_of_matches = sum(M(find(Org))<threshold);
        to_delete = find(M(find(Org))>threshold);
        [mcs,mgt] = find(Org);
        mcs(to_delete) = []; mgt(to_delete) = [];
    case 4 %'Mahmoud'
        number_of_matches = 0;
        for i = 1: size(M,1)
            for j = 1:size(M,2)
                if M(i,j) < threshold
                    number_of_matches = number_of_matches + 1;
                    M(:,j) = inf;
                    mcs = [mcs;i]; mgt = [mgt;j];
                    break
                end
            end
        end
    case 5 %'Kannappan'
        match_mat = inf(size(M));
        for i = 1: size(M,1)
            first_arg = min(M(i,:));
            for j = 1:size(M,2)
                second_arg = min(M(:,j));
                if (M(i,j) == first_arg) && (M(i,j) == second_arg)
                    match_mat(i,j) = M(i,j);
                    mcs = [mcs;i]; mgt = [mgt;j];
                end
            end
        end
        number_of_matches = min(...
            [sum(sum((match_mat < threshold))),sA,sB]);
    case 6 %'Hopcroft-Karp'
        [Org,~] = assignment_hungarian(1-(M<threshold));
        number_of_matches = sum(M(find(Org))<threshold);
        to_delete = find(M(find(Org))>threshold);
        [mcs,mgt] = find(Org);
        mcs(to_delete) = []; mgt(to_delete) = [];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Recall = number_of_matches/sA;
Precision = number_of_matches/sB;
F = 2 * Precision .* Recall ./ (Precision + Recall);
F(number_of_matches == 0) = 0;
