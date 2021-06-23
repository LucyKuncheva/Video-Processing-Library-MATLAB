function index = fox_uniform_summary(n,k)
%=======================================================================
%fox_uniform_summary Return the indices of k uniformly distributed frames
%within n video frames.
%   function index = fox_uniform_summary(n,k) 
%
%   Input -----
%      'n': total number of frames in the video
%      'k': number of frames in the summary
%
%   Output -----
%      'index': the indices of the chosen frames
%
%   Example:
%      index = fox_uniform_summary(100,10)
%========================================================================

% (c) Fox's Vis Toolbox                                             ^--^
% 03.03.2017 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%
%==========================================================================

index = linspace(1,n,k+1); % the bouondaries of the uniform segments
index = round(index - (index(2)-index(1)) / 2); 
index(1) = []; 

