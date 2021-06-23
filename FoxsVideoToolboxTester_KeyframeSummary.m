% FoxsVideoToolboxTester_KeyframeSummary
% 23/06/2021

clear, clc, close all

% fn = 'Videos/car_over_camera.mp4';
% Note: If you have the nerves and patience, you can make this interactive
% :)

fn = 'Videos/playing_ball.mp4';

k = 9; % segment number, if known - needed for the uniform segmentation 

if ~exist(fn,'file')
    error('Video file does not exist.')
end

% (1) Process the video / Retrieve the data array -------------------------
fn_mat = strtrim(strtok(fn,'.')); % remove the extension

if ~exist([fn_mat,'.mat'],'file')
    fprintf('Process the video to extract features.\n')
    fprintf(['A mat file of the same name will be ',...
        'stored in the same folder.\n\n'])
    % data = fox_features_from_video(fn);
    data = fox_features_from_video(fn,'RGB', 16, 8);
end

load(fn_mat) % data is in memory
fprintf('Data is in.\n\n')

% (2) Extract the key summaries -------------------------------------------

% (a) Uniform summary
ukf = fox_uniform_summary(size(data,1),k);

% (b) Segmentation summary
% 'par': an array with parameters
%             par(1) = number of stds for the change threshold (default 1)
%             par(2) = minimum segment length (# frames, default 6) 
%             par(3) = block size for smoothing (# frames, default 4)

par = [0.5,50,10]; % fewer keyframes
skf = fox_segmentation_summary(data,par);

% (3) Retrieve the frames -------------------------------------------------
ukf_frames = fox_retrieve_frames(fn,ukf);
fprintf('Keyframe extraction --UNIFORM-- completed.\n')

skf_frames = fox_retrieve_frames(fn,skf);
fprintf('Keyframe extraction --SEGMENTATION-- completed.\n\n')


% (4) Create montages of the two summaries --------------------------------
sz1 = ceil(sqrt(numel(ukf)));
sz2 = ceil(sqrt(numel(skf)));
fox_montage(ukf_frames,[sz1,sz1],[0.8, 0.8, 1])
fox_montage(skf_frames,[sz2,sz2],[0.8, 0.8, 1])


