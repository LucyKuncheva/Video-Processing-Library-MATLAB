function [match, value] = fox_match_two_vectors(a,b,threshold,d)
%=======================================================================
%fox_match_two_vectors Match two vectors
%   [match, value] = fox_match_two_vectors(a,b,threshold,d) calculates 
%   the distance between two vectors and returns a logical value 'match'
%   as well as the value of the distance.
%
%   Input -----
%      'a': 1-by-N vector with image representation
%      'b': 1-by-N vector with image representation
%      'threshold': threshold for the match; match is declared if 
%                   distance is <= threshold
%      'd': distance type
%           1 Euclidean, 2 Minkowski (L1 norm), 3 Cosine (angular), 
%           4 SURF
%
%   Output -----
%      'match': match output - 0 no match, 1 match (logical variable)
%      'value': distance value
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

switch d
    case 1 % Euclidean
        value = sqrt((a(:)-b(:))'*(a(:)-b(:))); % Euclidean
    case 2 % Minkowski
        value = sum(abs(a(:)-b(:)));
    case 3 % Cosine (angular distance)
        value = 2*acos((a(:)-b(:))'*(a(:)-b(:))/(norm(a) * norm(b)))/pi;
end
match = value < threshold;
