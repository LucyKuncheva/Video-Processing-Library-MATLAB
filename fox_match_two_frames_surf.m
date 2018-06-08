function [match, value] = fox_match_two_frames_surf(A,B,threshold,vis)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% A,B: images to match
% threshold: match is declared if distance is <= threshold
% d: 1 Euclidean, 2 Minkowski (L1 norm), 3 Cosine (angular), 4 SURF
% vis: 0/1 (optional, default 0) set to non-zero to display the two images
%
% Output
%
% match: 0 no match, 1 match (logical variable)
% value: distance
%
% Note: Needs the Computer Vision Toolbox
%==========================================================================
% Author: Lucy Kuncheva

if nargin == 3, vis = 0; end 

if ndims(A) == 3; A = rgb2gray(A); B = rgb2gray(B); end
s1 = detectSURFFeatures(A);
s2 = detectSURFFeatures(B);

[Features1, Points1] = extractFeatures(A, s1);
[Features2, Points2] = extractFeatures(B, s2);
Pairs = matchFeatures(Features1, Features2, 'Metric','SSD',...
    'MaxRatio',0.5,'MatchThreshold',5);
PairsReverse = matchFeatures(Features2, Features1,...
    'Metric','SSD','MaxRatio',0.5,'MatchThreshold',5);

p1 = size(Points1,1); p2 = size(Points2,1);

m = min(size(Pairs,1),size(PairsReverse,1)); % number of matched points

if vis % show the pictures
    matchedPoints1 = Points1(Pairs(:, 1), :);
    matchedPoints2 = Points2(Pairs(:, 2), :);
    matchedPointsR2 = Points1(PairsReverse(:, 2), :);
    matchedPointsR1 = Points2(PairsReverse(:, 1), :);
    figure
    subplot(2,1,1)
    showMatchedFeatures(A, B, matchedPoints1, matchedPoints2,...
        'montage');
    subplot(2,1,2)
    showMatchedFeatures(B, A, matchedPointsR2, matchedPointsR1,...
        'montage');

end

if ~isempty(p1) && ~isempty(p2) % there are salient points
    value = 1 - 2*m/(p1+p2); % mini F-measure
else
    value = inf; 
end
match = value < threshold;

