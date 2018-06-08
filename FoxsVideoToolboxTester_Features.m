% Fox's Video Toolbox Tester

clear, clc, close all

% Upload and show an image ------------------------------------------------
a = imread('betws_y_coed_small.jpg');
% a = uint8(cat(3,ones(500)*200,zeros(500),ones(500)*70)); single colour
% a = uint8(cat(3,ones(500)*255,zeros(500),zeros(500))); single colour
figure, subplot(221), imshow(a)
title('Original image')

% Extract RGB features ----------------------------------------------------
featureString = 'RGB'; % feature space
blocks = 9; % split into cells
bins = 0; % not a histogram
x_rgb = fox_get_features(a, featureString, blocks, bins); 

% Reconstruct the image with the mean RGB ---------------------------------
reconstructedImage = [1:3;4:6;7:9];
textBlocks = reshape(cellstr(('1':'9')'),3,3)';
subplot(222)
fox_plot_grid(3,3,textBlocks,gca)
title('Block numbering, 9 blocks')
v = reshape(x_rgb,3,numel(x_rgb)/3)';
colourMap = v(1:2:end,:)/255;
subplot(223)
imshow(reconstructedImage,colourMap,'initialmagnification','fit')
title('RGB feature space, 9 blocks')

% Extract histogram features ----------------------------------------------
featureString = 'H'; % feature space
blocks = 1; % no split
bins = 16; % histogram
x_h16 = fox_get_features(a, featureString, blocks, bins); 
x_h16 = x_h16/sum(x_h16); % scale to sum 1 
subplot(224), bar(x_h16)
title('Hue histogram, 16-bin, 1 block')
axis tight

