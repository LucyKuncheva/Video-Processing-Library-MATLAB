% Fox's Video Toolbox Tester

clear, clc, close all

% Upload and show an image ------------------------------------------------
a = imread('betws_y_coed_small.jpg');
aReverse = flip(a,2); % flipped image
figure, subplot(121), imshow(a), title('Original image')
subplot(122), imshow(aReverse), title('Reversed image')

% Extract RGB features ----------------------------------------------------
featureString = 'RGB'; % feature space
x_rgb1 = fox_get_features(a, featureString, 1);  % whole image
rx_rgb1 = fox_get_features(aReverse, featureString, 1); 
x_rgb9 = fox_get_features(a, featureString, 9); % 9 blocks
rx_rgb9 = fox_get_features(aReverse, featureString, 9); 

% Calculate match ---------------------------------------------------------
fprintf('Testing Frame Matching (RGB), Euclidean\n')

% Scale RGB feature values between 0 and 1 
xrgb1_scaled = x_rgb1/255;
xrgb9_scaled = x_rgb9/255;
rxrgb1_scaled = rx_rgb1/255;
rxrgb9_scaled = rx_rgb9/255;
% Maximum Euclidean distance would be sqrt(n) (minimum 0)
threshold = 0.5 * sqrt(numel(x_rgb1));
[match1, value1] = fox_match_two_vectors(xrgb1_scaled,...
    rxrgb1_scaled,threshold,1);
[match9, value9] = fox_match_two_vectors(xrgb9_scaled,...
    rxrgb9_scaled,threshold,1);
fprintf('\nThreshold %.4f\n',threshold)
fprintf('Original vs reversed - 1 block: %i, value %.4f\n',match1,value1)
fprintf('Original vs reversed - 9 blocks: %i, value %.4f\n',...
    match9,value9)

% Extract H histogram features --------------------------------------------
featureString = 'H'; % feature space
x_rgb1 = fox_get_features(a, featureString, 1,32);  % whole image
rx_rgb1 = fox_get_features(aReverse, featureString, 1,32); 
x_rgb9 = fox_get_features(a, featureString, 9,32); % 9 blocks
rx_rgb9 = fox_get_features(aReverse, featureString, 9,32); 

% Calculate match ---------------------------------------------------------
fprintf('\nTesting Frame Matching (H-histograms, 32 bins) Minkowski\n')

% Scale H feature values to sum 1 
xrgb1_scaled = x_rgb1/sum(x_rgb1);
xrgb9_scaled = x_rgb9/sum(rx_rgb1);
rxrgb1_scaled = rx_rgb1/sum(x_rgb9);
rxrgb9_scaled = rx_rgb9/sum(rx_rgb9);
threshold = 0.5;
[match1, value1] = fox_match_two_vectors(xrgb1_scaled,...
    rxrgb1_scaled,threshold,2);
[match9, value9] = fox_match_two_vectors(xrgb9_scaled,...
    rxrgb9_scaled,threshold,2);
fprintf('\nThreshold %.4f\n',threshold)
fprintf('Original vs reversed - 1 block: %i, value %.4f\n',match1,value1)
fprintf('Original vs reversed - 9 blocks: %i, value %.4f\n\n',...
    match9,value9)

% SURF matching -----------------------------------------------------------
visual = 1;

[matchs1, values1] = fox_match_two_frames_surf(a,a,threshold,...
    visual);

threshold = 0.5; % cuts off a "mini F-value"
[matchs2, values2] = fox_match_two_frames_surf(a,aReverse,threshold,...
    visual);

fprintf('\nTesting Frame Matching SURF\n')
fprintf('\nThreshold %.4f\n',threshold)
fprintf('Original vs Original %i, value %.4f\n',matchs1,values1)
fprintf('Original vs Reverse %i, value %.4f\n\n',matchs2,values2)
