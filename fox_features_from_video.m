function data = fox_features_from_video(fn,feature_string, blocks, bins)
%=======================================================================
%fox_features_from_video Calculate the features of the frames in a video.
%   data = fox_features_from_video(fn,feature_string, blocks, bins) 
%   extracts the features of the frames in a video and saves the data in
%   a mat file of the name of the video. 
%
%   Input -----
%      'fn': the name of the video file (full path)
%      'feature_string': One of the following - RGB, HSV, CHR, OHT, H
%                        (default 'RGB')   
%      'blocks': number of blocks to split the frames (default 9)
%      'bins': number of bins for histogram features (default 8)
%
%   Output -----
%      'data': an N-by-M array with data, where N is the number of frames
%      of the video and M is the number of extracted features.
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 23.06.2021 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

if ~exist(fn,'file')
    error('Video file does not exist.')
end

% Construct a multimedia reader object
v = VideoReader(fn); 

% Prepare a waitbar
ApproxLength = floor((v.Duration - 1)* v.FrameRate);
fc = 1; % frame counter
h = waitbar(0,'Please wait for all frames to be processed');

if nargin == 1
    feature_string = 'RGB';
    blocks = 9;
    bins = 8;
end 

data = [];
while hasFrame(v)
    vidFrame = readFrame(v);
    waitbar(fc/ApproxLength,h) % update the progress bar    
    x = fox_get_features(vidFrame, feature_string, blocks, bins);
    data = [data;x(:)'];
    fc = fc + 1;    
end
close(h)

fn_mat = strtrim(strtok(fn,'.')); % remove the extension
save(fn_mat, 'data')


