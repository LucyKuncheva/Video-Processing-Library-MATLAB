function frame_index = fox_segmentation_summary(data,par)
%=======================================================================
%fox_segmentation_summary Apply segmentation and keyframe extraction 
% using the closest-to-centroid method for each segment.
%   frame_index = fox_segmentation_summary(data,par) segments the video
%   represented as data into a number of segments obtained from the
%   algorithm. The segmentation method follows [1]. Subsequently, we 
%   take the frame closest to the centroid of each segment as advocated 
%   in [2]. 
%
%   Input -----
%      'data': a data array of size N-by-M where N is the number of 
%              frames in the video and M is the number of features 
%      'par': an array with parameters
%             par(1) = number of stds for the change threshold (default 1)
%             par(2) = minimum segment length (# frames, default 6) 
%             par(3) = block size for smoothing (# frames, default 4)
%
%   Output -----
%      'frame_index': an array with the indices of the selected keyframes
%
% [1] % Doherty, A. R.; Byrne, D.; Smeaton, A. F.; Jones, G. J. F. & 
% Hughes, M. Investigating keyframe selection methods in the novel 
% domain of passively captured visual lifelogs, Proceedings of the 2008 
% International Conference on Content-based Image and Video Retrieval 
% CIVR, 2008, 259-268.
% [2] Kuncheva L. I., P. Yousefi & J. Almeida, Comparing keyframe 
% summaries of egocentric videos: Closest-to-centroid baseline, 
% Proceedings of The Seventh International Conference on Image 
% Processing Theory, Tools and Applications (IPTA 2017), 2017, 
% Montreal, Canada. 
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 21.04.2017 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

% Segment the video -------------------------------------------------------

if nargin == 1
    par(1) = 1; % threshold = mu + sigma
    par(2) = 6; % 3 minutes for lifelogging data with 2 fpm 
    par(3) = 4; % 2 minutes for lifelogging data with 2 fpm
end

B1 = [data(1,:); data];
B2 = [data; data(end,:)]; 
d = sqrt(sum((B1 - B2).^2,2)); % distances between consecutive frames
d(1) = [];

% Group into blocks
N = size(data,1);
f = floor(N/par(3));
D = d;
if N ~= (f+1)*par(3)
    D = [d; zeros((f+1)*par(3)-N,1)]; % pad with 0s
end
md = mean(reshape(D',par(3),f+1)); % mean distances for the blocks

block_start = 1:par(3):N; % indices of the possible segment borders
cbi = find(md > mean(d) + par(1) * std(d));
candidate_borders = [0 block_start(cbi) N]; %#ok<*FNDSB>

% Enforce the minimum segment length (sequentail approach)
labels = zeros(N,1);
l = 0;
for i = 2:numel(candidate_borders)
    if candidate_borders(i) - candidate_borders(i-1) > par(2)
        l = l + 1;
        labels(candidate_borders(i-1)+1:candidate_borders(i)) = l;
    else % add to the previous segment
        labels(candidate_borders(i-1)+1:candidate_borders(i)) = l;
    end
end

% Take the cluster centroid of each segment -------------------------------

c = max(labels);
for i = 1:c
    mdata = mean(data(labels == i,:),1);
    % find the closest instance
    frame_index(i) = knnsearch(data,mdata);
end


