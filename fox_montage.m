function fox_montage(f,s,c,w)
%==========================================================================
% (c) Fox's Video Toolbox                                           ^--^
% 03.03.2017 -----------------------------------------------------  \oo/
%                                                                   -\/-%
% Input
%
% f: cell array with n images of the same size
% s: size [rows,columns] of the montage (optional)
% c: colour of the outside border of each image (optional)
% w: with of the border, proportion of the smaller dimension of the
%         image (optional, default = 0.08)
% 
%  If 'c' is not specified, MATLAB 'montage' function is used (no gaps   
%  between the images). If 'c' is of size (1,3), this is taken to be the
%  colour of all the borders. The values must be between 0 and 1. If c is 
%  of size (n,3), each image will have a border with colour specified in 
%  the corresponding row in 'c'.
%==========================================================================
% Author: Lucy Kuncheva

resizeconstant = 1;
figure
figc = get(gcf,'Color');
szim = size(f{1}); % size of the images
if nargin > 2 % colour specified => border
    if size(c,1) == 1 % one colour for all frames
        c = repmat(c,numel(f),1);
    end
    if nargin == 3 % width not speified
        w = 0.08; % default proportion
    end
    wb = round(w*min(szim(1:2))); % border width    
    for i = 1:numel(f)
        im1 = inset_image(f{i},wb,c(i,:));
        im2 = inset_image(im1,max(1,round(wb/4)),figc);
        F(:,:,:,i) = im2;
    end
else
    for i = 1:numel(f)
        F(:,:,:,i) = imresize(f{i},resizeconstant);
    end
end

if nargin == 1 || isempty(s)
    montage(F)
else
    montage(F,'Size',s)
end
end

%==========================================================================
function cbm = inset_image(im,wb,cb) % ------------------------------------
% inset image with border width wb and border colour cb
szim = size(im);
bm = ones(szim(1)+2*wb,szim(2)+2*wb); % expanded (border) matrix
% Create the 3-pane colour border matrix
cbm = uint8(cat(3,bm*cb(1),bm*cb(2),bm*cb(3))*255);
cbm(wb+1:end-wb,wb+1:end-wb,:) = im; % inset the image
end
%==========================================================================
