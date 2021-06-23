function frames = fox_retrieve_frames(fn,index)
%=======================================================================
%fox_retrieve_frames Returns the frames with numbers in array 'index' by
% reading the original video.
%   frames = fox_retrieve_frames(fn,index) 
%
%   Input -----
%      'fn': video filename (full path) 
%      'index': number of the frames to be retrieved
%
%   Output -----
%      'frames': a cell array with the retreieved images in the order 
%                they are given in 'index'
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 22.06.2021 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

if ~exist(fn,'file') % create the output folder 
    error('Video does not exist.')
end

% Construct a multimedia reader object
v = VideoReader(fn); 

[sorted_index, si] = sort(index);

i = 1; j = 1;
while hasFrame(v) && j <= numel(index)
    vidFrame = readFrame(v);
    if i == sorted_index(j)
        frames{si(j)} = vidFrame;
        j = j + 1;
    end
    i = i + 1;
end


