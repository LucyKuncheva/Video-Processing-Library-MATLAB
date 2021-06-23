function fox_store_frames(fn,odir)
%=======================================================================
%fox_store_frames Store the frames in the video in file 'fn' in folder
%'odir'.
%   fox_store_frames(fn,odir) 
%
%   Input -----
%      'fn': video filename
%      'odir': folder name without the divider '/' or '\'
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 08.06.2018 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

if ~exist(odir,'dir') % create the output folder 
    mkdir(odir)
end

% Construct a multimedia reader object
v = VideoReader(fn); 

% Prepare a waitbar
ApproxLength = floor((v.Duration - 1)* v.FrameRate);
fc = 1; % frame counter
h = waitbar(0,'Please wait for all frames to be stored');

while hasFrame(v)
    vidFrame = readFrame(v);
    waitbar(fc/ApproxLength,h) % update the progress bar    
    frame_file_name = [odir,'/',num2str(fc),'.jpg'];
    imwrite(vidFrame,frame_file_name)
    fc = fc + 1;    
end
close(h)


