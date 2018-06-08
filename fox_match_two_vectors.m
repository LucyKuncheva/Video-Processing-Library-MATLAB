function [match, value] = fox_match_two_vectors(a,b,threshold,d)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% a,b: vectors 1-by-n = image *representations* to match
% threshold: match is declared if distance is <= threshold
% d: 1 Euclidean, 2 Minkowski (L1 norm), 3 Cosine (angular), 4 SURF
%
% Output
%
% match: 0 no match, 1 match (logical variable)
% value: distance
%==========================================================================
% Author: Lucy Kuncheva

switch d
    case 1 % Euclidean
        value = sqrt((a(:)-b(:))'*(a(:)-b(:))); % Euclidean
    case 2 % Minkowski
        value = sum(abs(a(:)-b(:)));
    case 3 % Cosine (angular distance)
        value = 2*acos((a(:)-b(:))'*(a(:)-b(:))/(norm(a) * norm(b)))/pi;
end
match = value < threshold;
